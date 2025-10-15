local file = io.open("input.txt", "r")
-- Transform the input file into a 2D array of strings
local table = {}
row = 0
col = 0
for line in file:lines() do
    for i in line:length() do
        if(line:char(i) == "<" or line:char(i) == ">" or line:char(i) == "=") then
            table[] -- Add the <, > or = to the table
        end
    if(line:char)
-- Figure out a strategy to print the table around the 2D array


file.close()