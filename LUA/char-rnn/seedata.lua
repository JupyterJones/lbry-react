  
local sqlite3 = require("lsqlite3")
--os.remove('test2.db')
local db = sqlite3.open('BASEalice2.db')

--local tablesetup = [[CREATE TABLE IF NOT EXISTS test (content);]]

--db:exec( tablesetup )

--VAR = "EVEN MORE new Test Data"
--db:exec('INSERT INTO test VALUES ("'..VAR..'")')

--Delete below is working
--ROID = 1
--db:exec('DELETE FROM test WHERE ROWID =("'..ROID..'")')

for row in db:nrows("SELECT rowid,* FROM test") do
  X, Y = row.rowid, row.content
  print(X, Y)
end
