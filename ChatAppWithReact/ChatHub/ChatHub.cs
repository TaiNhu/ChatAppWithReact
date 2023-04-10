using ChatAppWithReact.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using System.Buffers.Text;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Text;
using System.Text.RegularExpressions;

namespace ChatAppWithReact.ChatHub
{
    public interface ClientHub
    {
        Task SendMessage(Message message);
        Task ReceivedMessage(Message message);
    }

    public class Data
    {
        public string DataStream { get; set; }
        public string Content { get; set; }
        public string RoomId { get; set; }
        public string Owner { get; set; }
        

    }

    public class ChatHub : Hub<ClientHub>
    {

        private readonly DataContext _db;
        public ChatHub(DataContext db) 
        {
            _db = db;
        }

        [Authorize]
        public async Task<string?> JoinGroup(string? roomId, string userName)
        {
            Room room = new Room();
            if(roomId != null)
            {
                room.Id = roomId;
            } else
            {
                try{
                    User user = _db.Users.First(u => u.Id == userName);
                } catch {
                    return "Companion not found";
                }
                room.Id = Guid.NewGuid().ToString();
                _db.Rooms.Add(room);
                _db.Members.Add(new Member()
                {
                    RoomId= room.Id,
                    MemberId= userName
                });
                _db.Members.Add(new Member()
                {
                    RoomId = room.Id,
                    MemberId = Context.User.FindFirstValue("Id")
                });
                _db.SaveChanges();
            }
            await this.Groups.AddToGroupAsync(this.Context.ConnectionId, room.Id);
            Console.WriteLine(this.Context.UserIdentifier);
            return null;
        }

        [Authorize]
        public async Task ReceivedMessage(Message message)
        {
            message.Id = Guid.NewGuid().ToString();
            _db.Messages.Add(message);
            _db.SaveChanges();
            await Clients.Group(message.RoomId).ReceivedMessage(message);
        }

        [Authorize]
        public async Task Upload(IAsyncEnumerable<Data> dataStream)
        {
            string buffer = "";
            Data data = new Data();
            await foreach (var b in dataStream)
            {
                buffer += b.DataStream;
                data = b;
            }
            buffer = Regex.Replace(buffer, @"^data\:.*;base64,", String.Empty);
            byte[] bytes = Convert.FromBase64String(buffer);
            string fileName = Guid.NewGuid().ToString() + data.Content;
            File.WriteAllBytes(fileName, bytes);
            Console.WriteLine("Stream compleleted");
            Message message = new Message()
            {
                Id = Guid.NewGuid().ToString(),
                Content = fileName,
                TypeId = 2,
                Owner = data.Owner,
                RoomId = data.RoomId,
            };
            _db.Messages.Add(message);
            _db.SaveChanges();
            await Clients.Group(data.RoomId).ReceivedMessage(message);
        }

        [Authorize]
        public async IAsyncEnumerable<object> Download(string fileName, int delayTime, [EnumeratorCancellation] CancellationToken cancellationToken)
        {
            string base64Data = Convert.ToBase64String(File.ReadAllBytes(fileName));
            int chunkSize = 1024;
            int chunks = base64Data.Length / chunkSize;
            int count = 0;
            do
            {
                string streamData = base64Data.Substring(count * chunkSize, Math.Min(base64Data.Length - count * chunkSize, chunkSize));
                yield return new {
                    Process= (double) count / chunks * 100,
                    Data = streamData
                };
                count++;
                cancellationToken.ThrowIfCancellationRequested();
                await Task.Delay(delayTime, cancellationToken);
            } while (count <= chunks);
            Console.WriteLine("Download completed");
        }

    }
}
