using LabApp.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

// Hardcoded directly to bypass any Azure environment variable or quotation mark formatting issues
var connectionString = "Server=tcp:sql-todo-rahul.database.windows.net,1433;Initial Catalog=TodoDb;Persist Security Info=False;User ID=adminsql;Password=admin2005@;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

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