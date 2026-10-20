using LabApp.Data;
using LabApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LabApp.Controllers;

public class TodoController : Controller
{
    private readonly AppDbContext _db;
    public TodoController(AppDbContext db) => _db = db;

    public async Task<IActionResult> Index()
    {
        ViewBag.Machine = Environment.MachineName;
        ViewBag.DbServer = _db.Database.GetDbConnection().DataSource;
        return View(await _db.Todos.OrderBy(t => t.Id).ToListAsync());
    }

    [HttpPost]
    public async Task<IActionResult> Add(string title)
    {
        if (!string.IsNullOrWhiteSpace(title))
        {
            _db.Todos.Add(new TodoItem { Title = title.Trim() });
            await _db.SaveChangesAsync();
        }
        return RedirectToAction(nameof(Index));
    }

    [HttpPost]
    public async Task<IActionResult> Toggle(int id)
    {
        var item = await _db.Todos.FindAsync(id);
        if (item != null) { item.Done = !item.Done; await _db.SaveChangesAsync(); }
        return RedirectToAction(nameof(Index));
    }

    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        var item = await _db.Todos.FindAsync(id);
        if (item != null) { _db.Todos.Remove(item); await _db.SaveChangesAsync(); }
        return RedirectToAction(nameof(Index));
    }
}
