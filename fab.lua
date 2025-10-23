local file = io.open("input.txt", "r")

-- Transform the input file into a 2D array of strings
local words = {}

for line in file:lines() do
    for i = 1, #line do
        local ch = string.sub(line, i, i)
        if(ch == "<" or ch == ">" or ch == "=") then
            table.insert(words, ch) -- Add the <, > or = to the table
        end
    end
end    

-- Read lines until a line starting with "*" (EOF) is found
local lines = {}
for line in file:lines() do
    if line:sub(1,1) == "*" then break end
    table.insert(lines, line)
end

-- Loop through each line in lines array
local i = 1
while i <= #lines do
    -- Line with the alignmrnt information
    local align = lines[i]

    -- Get the number of cols from align
    local nCols = #align

    -- Read a block of text until we get to the next align info
    local table_lines = {}
    while i <= #lines and not lines[i]:match("^[<>=]+$") do
        table.insert(table_lines, lines[i])
        i = i + 1
    end

    -- Split data lines into entries for each column
    local data = {}
    for _, line in ipairs(table_lines) do
        local row = {}
        for entry in line:gmatch("([^&]+)") do
            table.insert(row, entry)
        end
        table.insert(data, row)
    end

    -- Find the maximum width for each column
    local widths = {}
    for col = 1, nCols do
        local maxWidth = 0
        for _, row in ipairs(data) do
            if #row[c] > maxWidth then maxWidth = #row[c] end
        end

        widths[col] = maxWidth
    end

    -- Calculate the total width of the table
    local total_width = 1
    for col = 1, nCols do total_width = total_width + widths[col] + 3 end
    total_width = total width + 1

    -- Print the top border
    local top_and_bottom = "@" .. string.rep("-", total_width - 2) .. "@"

    -- Print separators between cols
    local sep = "|"
    for col = 1, nCols do
        sep = sep .. string.rep("-", widths[col] + 2) 
        if c == nCols then
            sep = sep .. "|"
        else
            sep = sep .. "+"
        end
    end
end

