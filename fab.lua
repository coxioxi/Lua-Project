local file = io.open("input.txt", "r")
if not file then error("Cannot open input.txt") end

-- Read lines until a line starting with "*" is found
local lines = {}
for line in file:lines() do
    if line:sub(1,1) == "*" then break end
    table.insert(lines, line)
end
file:close()

local i = 1
while i <= #lines do
    -- Alignment line
    local align = lines[i]
    local nCols = #align
    i = i + 1

    -- Read all lines until next alignment line or end
    local table_lines = {}
    while i <= #lines and not lines[i]:match("^[<>=]+$") do
        table.insert(table_lines, lines[i])
        i = i + 1
    end

    -- Skip empty blocks
    if #table_lines == 0 then
        goto continue
    end

    -- Split lines into columns
    local data = {}
    for _, line in ipairs(table_lines) do
        local row = {}
        for entry in line:gmatch("([^&]+)") do
            table.insert(row, entry)
        end
        table.insert(data, row)
    end

    -- Compute max widths per column
    local widths = {}
    for col = 1, nCols do
        local maxWidth = 0
        for _, row in ipairs(data) do
            if row[col] and #row[col] > maxWidth then
                maxWidth = #row[col]
            end
        end
        widths[col] = maxWidth
    end

    -- Compute total table width
    local total_width = 1
    for col = 1, nCols do
        total_width = total_width + widths[col] + 3
    end
    total_width = total_width + 1

    local top_bottom = "@" .. string.rep("-", total_width - 2) .. "@"

    -- Separator line between header and body
    local sep = "|"
    for col = 1, nCols do
        sep = sep .. string.rep("-", widths[col]+2)
        if col == nCols then
            sep = sep .. "|"
        else
            sep = sep .. "+"
        end
    end

    -- Helper function to align text
    local function align_text(text, width, align_type)
        if align_type == "<" then
            return text .. string.rep(" ", width - #text)
        elseif align_type == ">" then
            return string.rep(" ", width - #text) .. text
        else -- "=" center
            local left_padding = math.floor((width - #text) / 2)
            local right_padding = width - #text - left_padding
            return string.rep(" ", left_padding) .. text .. string.rep(" ", right_padding)
        end
    end

    -- Print table
    print(top_bottom)

    -- Header row
    local header = "|"
    for col = 1, nCols do
        header = header .. " " .. align_text(data[1][col], widths[col], align:sub(col,col)) .. " |"
    end
    print(header)

    print(sep)

    -- Body rows
    for row = 2, #data do
        local row_str = "|"
        for col = 1, nCols do
            row_str = row_str .. " " .. align_text(data[row][col], widths[col], align:sub(col,col)) .. " |"
        end
        print(row_str)
    end

    print(top_bottom)

    ::continue::
end
