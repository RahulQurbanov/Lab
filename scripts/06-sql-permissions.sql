-- Run in SSMS on vm-sql (Lab 1.1 Step 8)
CREATE LOGIN [LAB\VM-IIS$] FROM WINDOWS;
ALTER SERVER ROLE dbcreator ADD MEMBER [LAB\VM-IIS$];   -- lets EnsureCreated create TodoDb

-- Verify after the app has run once:
-- SELECT * FROM TodoDb.dbo.Todos;
