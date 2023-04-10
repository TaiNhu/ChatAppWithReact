using System;
using System.Collections.Generic;

namespace ChatAppWithReact.Models;

public partial class Member
{
    public int Id { get; set; }

    public string? MemberId { get; set; }

    public string? RoomId { get; set; }

    public virtual User? MemberNavigation { get; set; }

    public virtual Room? Room { get; set; }
}
