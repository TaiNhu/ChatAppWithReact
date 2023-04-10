using ChatAppWithReact.ChatHub;
using ChatAppWithReact.Models;
using ChatAppWithReact.Requirements;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAuthentication("auth").AddCookie("auth", options =>
{
    options.Cookie.Name = "auth";
    options.LoginPath = "/auth/login";
});

builder.Services.AddAuthorization(configure =>
{
    configure.AddPolicy("Authen", policy =>
    {
        policy.RequireAuthenticatedUser();
        policy.AddRequirements(new ChatAppWithReact.Requirements.Requirement());
    });
});

builder.Services.AddSingleton<IAuthorizationHandler, ChatAppWithReact.Requirements.RequirementHandler>();

builder.Services.AddCors(setup =>
{
    setup.AddPolicy("SpecificDomain", policy =>
    {
        policy.WithOrigins("http://127.0.0.1:5173").AllowAnyHeader();
    });
});

builder.Services.AddDbContext<DataContext>(action =>
{
    action.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
});


builder.Services.AddControllers().AddJsonOptions(x =>
   x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);

builder.Services.AddSignalR();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseStaticFiles();

app.UseCors("SpecificDomain");
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.MapHub<ChatHub>("/chat");

app.Run();
