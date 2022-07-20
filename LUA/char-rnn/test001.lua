
-- SETUP HIGHSCORES !!!
filez = 'alice.db'
local path = system.pathForFile( filez, system.DocumentsDirectory )
 
-- io.open opens a file at path. returns nil if no file found
local file = io.open( path, "r" )
 
if file then
	print(filez,"Found!")
	end
	io.close( file )
else
	print(filez,"NOT Found!")
end