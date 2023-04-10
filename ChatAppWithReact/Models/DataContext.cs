using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ChatAppWithReact.Models;

public partial class DataContext : DbContext
{
    public DataContext()
    {
    }

    public DataContext(DbContextOptions<DataContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Member> Members { get; set; }

    public virtual DbSet<Message> Messages { get; set; }

    public virtual DbSet<MessageType> MessageTypes { get; set; }

    public virtual DbSet<Room> Rooms { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-KSTC91T;Initial Catalog=chatappcsharp;User ID=sa;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Member>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__members__3213E83F5FBDA059");

            entity.ToTable("members");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.MemberId)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("memberId");
            entity.Property(e => e.RoomId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("roomId");

            entity.HasOne(d => d.MemberNavigation).WithMany(p => p.Members)
                .HasForeignKey(d => d.MemberId)
                .HasConstraintName("FK__members__memberI__5629CD9C");

            entity.HasOne(d => d.Room).WithMany(p => p.Members)
                .HasForeignKey(d => d.RoomId)
                .HasConstraintName("FK__members__roomId__571DF1D5");
        });

        modelBuilder.Entity<Message>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__messages__3213E83F4103C7BF");

            entity.ToTable("messages");

            entity.Property(e => e.Id)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("id");
            entity.Property(e => e.Content)
                .HasMaxLength(255)
                .HasColumnName("content");
            entity.Property(e => e.No)
                .ValueGeneratedOnAdd()
                .HasColumnName("no");
            entity.Property(e => e.Owner)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("owner");
            entity.Property(e => e.RoomId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("roomId");
            entity.Property(e => e.TypeId).HasColumnName("typeId");

            entity.HasOne(d => d.OwnerNavigation).WithMany(p => p.Messages)
                .HasForeignKey(d => d.Owner)
                .HasConstraintName("FK__messages__owner__5BE2A6F2");

            entity.HasOne(d => d.Room).WithMany(p => p.Messages)
                .HasForeignKey(d => d.RoomId)
                .HasConstraintName("FK__messages__roomId__5AEE82B9");

            entity.HasOne(d => d.Type).WithMany(p => p.Messages)
                .HasForeignKey(d => d.TypeId)
                .HasConstraintName("FK__messages__typeId__59FA5E80");
        });

        modelBuilder.Entity<MessageType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__messageT__3213E83FA75C3777");

            entity.ToTable("messageTypes");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Type)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("type");
        });

        modelBuilder.Entity<Room>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__rooms__3213E83FE264D3F0");

            entity.ToTable("rooms");

            entity.Property(e => e.Id)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("id");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__users__3213E83F36D50B64");

            entity.ToTable("users");

            entity.Property(e => e.Id)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("id");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
