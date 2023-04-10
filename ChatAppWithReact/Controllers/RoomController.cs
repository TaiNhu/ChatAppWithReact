using ChatAppWithReact.ChatHub;
using ChatAppWithReact.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace ChatAppWithReact.Controllers
{

    public class RoomExtend
    {
        public Room? Room { get; set; } = new Room();

        public List<Member>? Members { get; set; } = null;

        public List<Message>? Messages { get; set; } = null;

        public string? LastMessage { get; set; } = null;

    }


    [ApiController]
    [Route("/Rooms")]
    public class RoomController : ControllerBase
    {

        private readonly DataContext _db;


        public RoomController(DataContext db)
        {
            _db = db;
        }

        [HttpGet("")]
        [Authorize]
        public IActionResult Get()
        {
            string memberId = HttpContext.User.FindFirstValue("Id");
            FormattableString sql = $"select rooms.id from rooms inner join members on members.roomId = rooms.Id where members.memberId = {memberId}";
            IEnumerable<Room> rooms = _db
                .Rooms
                .FromSqlInterpolated<Room>(sql).ToArray();
            List<RoomExtend>? roomExtend = rooms.Select<Room, RoomExtend>(r => new RoomExtend()
            {
                Room = r,
                Members = _db.Members.Select<Member, Member>((Member m) => new Member()
                {
                    Id = m.Id,
                    MemberId = m.MemberId,
                    RoomId = m.RoomId
                }).Where<Member>(m => m.RoomId == r.Id).ToList(),
                Messages = _db.Messages.Select<Message, Message>(m => new Message()
                {
                    Id = m.Id,
                    Content = m.Content,
                    RoomId= m.RoomId,
                    Owner= m.Owner,
                    TypeId= m.TypeId,
                    No= m.No
                }).Where<Message>(m => m.RoomId== r.Id).OrderBy<Message, int>(m => m.No).Reverse().Take(20).Reverse().ToList(),
                LastMessage= (from m in _db.Messages
                              where m.RoomId == r.Id
                              orderby m.No descending
                              select m.Content).FirstOrDefault<string>()
            })?.ToList();
        return Ok(roomExtend);
        }

        [HttpPost("{memberId}")]
        [Authorize]
        public IActionResult Post([FromRoute] string memberId)
        {
            Room room = new Room() { Id = Guid.NewGuid().ToString() };
            
            _db.Rooms.Add(room);
            _db.SaveChanges();
            for (int i = 0; i < 2; i++)
            {
                Member member = new Member()
                {
                    MemberId = i < 1 ? memberId : HttpContext.User?.FindFirst(ClaimTypes.Name)?.Value,
                    RoomId = room.Id
                };
                _db.Members.Add(member);
                _db.SaveChanges();
            }
            return Ok(_db.Rooms.AsEnumerable<Room>().Single<Room>(r => r.Id == room.Id));
        }

    }
}
