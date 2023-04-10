using ChatAppWithReact.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Client;
using Newtonsoft.Json.Linq;
using System.Security.Claims;
using System.Text.Json;

namespace ChatAppWithReact.Controllers
{

    public class UserExtend
    {
        public string Id { get; set; } = null!;
        public bool IsRemmember { get; set; } = false;

    }

    [ApiController]
    [Route("/Auth")]
    public class AuthController : ControllerBase
    {
        private readonly DataContext _db;

        public AuthController(DataContext db) 
        {
            _db = db;
        }


        [HttpPost("Login")]
        public async Task<IActionResult> Index([FromBody] UserExtend value)
        {
            User? user = await SignIn(value);
            if (user != null)
            {
                return Ok(user);
            }
            return BadRequest("User had existed");
        }

        [HttpGet("Logout")]
        [Authorize]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync();
            return Ok("SignOut success");
        }


        private async Task<User?> SignIn(UserExtend value)
        {
            User user = _db.Users.AsEnumerable().SingleOrDefault(user => user.Id == value.Id, new Models.User());

            if (user.Id != null)
            {
                await LoginPartical(user, value);
                return user;
            }
            User? u = new Models.User() { Id = value.Id };
            if(u != null)
            {
                await _db.Users.AddAsync(u);
                await _db.SaveChangesAsync();
                await LoginPartical(u, value);
                return u;
            }
            return null;
        }

        private async Task LoginPartical(User user, UserExtend value)
        {
            List<Claim> claims = new List<Claim>()
                {
                    new Claim("Id", user.Id)
                };
            ClaimsIdentity identity = new ClaimsIdentity(claims, "auth");
            ClaimsPrincipal pricipal = new ClaimsPrincipal(identity);
            AuthenticationProperties properties = new AuthenticationProperties()
            {
                IsPersistent = value.IsRemmember
            };
            await HttpContext.SignInAsync("auth", pricipal, properties);
        }
    }
}
