using System;
using System.Collections.Generic;

namespace ChatAppWithReact.Models;

public partial class Room
{
    public string Id { get; set; } = null!;

    public virtual ICollection<Member> Members { get; } = new List<Member>();

    public virtual ICollection<Message> Messages { get; } = new List<Message>();
}
