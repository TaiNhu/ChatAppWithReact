using ChatAppWithReact.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ChatAppWithReact.Controllers
{
    [ApiController]
    [Route("/Messages")]
    public class MessageController : ControllerBase
    {
        private readonly DataContext _db;

        public MessageController(DataContext db)
        {
            _db = db;
        }

        [HttpGet("{roomId}")]
        [Authorize]
        public IActionResult Index([FromRoute] string roomId)
        {
            IEnumerable<Message> messages = from message in _db.Messages
                                            where message.RoomId == roomId
                                            select message;
            return Ok(messages);
        }
    }
}
