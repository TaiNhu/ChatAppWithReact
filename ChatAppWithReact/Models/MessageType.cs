using System;
using System.Collections.Generic;

namespace ChatAppWithReact.Models;

public partial class MessageType
{
    public int Id { get; set; }

    public string? Type { get; set; }

    public virtual ICollection<Message> Messages { get; } = new List<Message>();
}
