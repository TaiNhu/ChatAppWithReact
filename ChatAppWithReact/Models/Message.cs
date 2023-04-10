using System;
using System.Collections.Generic;

namespace ChatAppWithReact.Models;

public partial class Message
{
    public string Id { get; set; } = null!;

    public string? Content { get; set; }

    public int? TypeId { get; set; }

    public string? RoomId { get; set; }

    public string? Owner { get; set; }

    public int No { get; set; }

    public virtual User? OwnerNavigation { get; set; }

    public virtual Room? Room { get; set; }

    public virtual MessageType? Type { get; set; }
}
