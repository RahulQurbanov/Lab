using LabApp.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

// Safely check for null, empty, or whitespace and fallback immediately to your Azure SQL connection string
var rawConn = builder.Configuration.GetConnectionString("DefaultConnection");
var connectionString = string.IsNullOrWhiteSpace(rawConn) 
    ? "Server=tcp:sql-todo-rahul.database.windows.net,1433;Initial Catalog=TodoDb;Persist Security Info=False;User ID=adminsql;Password=admin2005@;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    : rawConn;

builder.Services.AddDbContext<AppDbContext>(o => o.UseSqlServer(connectionString));

var app = builder.Build();

// Creates the database and Todos table automatically on first start (no migrations needed).
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.EnsureCreated();
}

app.UseStaticFiles();
app.UseRouting();
app.MapControllerRoute("default", "{controller=Todo}/{action=Index}/{id?}");
app.Run();