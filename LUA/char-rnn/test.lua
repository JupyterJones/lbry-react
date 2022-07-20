
-- SETUP HIGHSCORES !!!
local json = require("json")
local path = system.pathForFile( "highscores.txt", system.DocumentsDirectory )
 
-- io.open opens a file at path. returns nil if no file found
local file = io.open( path, "r" )
 
if file then
	print("Highscore File Found!")
	-- read all contents of file into a string
	local contents = file:read( "*a" )
	highscoreTable = json.decode(contents)
	
	TrialsLeft = highscoreTable[23]
	
	if highscoreTable[12] == 1 then
		fireBombUnlocked = true
	else
		fireBombUnlocked = false
	end
	
	print(highscoreTable[1])
	io.close( file )
else
	-- create file because it doesn't exist yet
	fireBombUnlocked = false
	print("Creating New Highscore File!")
	file = io.open( path, "w" )
	-- the 11th value is the volume, the 12th is a flag to set the unlock status!!!
	highscoreTable = {10000, 9000, 8000, 7000, 6000, 5000, 4000, 3000, 2000, 1000, 100, 0, 10000, 9000, 8000, 7000, 6000, 5000, 4000, 3000, 2000, 1000, 4}
	
	TrialsLeft = highscoreTable[23]
	local highscoreTableJSON = json.encode(highscoreTable)
	file:write(highscoreTableJSON)
	io.close( file )
end