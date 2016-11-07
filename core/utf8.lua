module( "core.utf8", package.seeall )

function charbytes (s, i)
    i = i or 1
    local c = string.byte(s, i)

    if c > 0 and c <= 127 then
        return 1
    elseif c >= 194 and c <= 223 then
        local c2 = string.byte(s, i + 1)
        return 2
    elseif c >= 224 and c <= 239 then
        local c2 = s:byte(i + 1)
        local c3 = s:byte(i + 2)
        return 3
    elseif c >= 240 and c <= 244 then
        local c2 = s:byte(i + 1)
        local c3 = s:byte(i + 2)
        local c4 = s:byte(i + 3)
        return 4
    end
end

function len (s)
    local pos = 1
    local bytes = string.len(s)
    local l = 0

    while pos <= bytes and l ~= chars do
        local c = string.byte(s,pos)
        l = l + 1

        pos = pos + charbytes(s, pos)
    end

    if chars ~= nil then
        return pos - 1
    end

    return l
end

function sub (s, i, j)
    j = j or -1

    if i == nil then
        return ""
    end

    local pos = 1
    local bytes = string.len(s)
    local l = 0

    local l = (i >= 0 and j >= 0) or len(s)
    local startChar = (i >= 0) and i or l + i + 1
    local endChar = (j >= 0) and j or l + j + 1

    if startChar > endChar then
        return ""
    end

    local startByte, endByte = 1, bytes

    while pos <= bytes do
        l = l + 1

        if l == startChar then
            startByte = pos
        end

        pos = pos + charbytes(s, pos)

        if l == endChar then
            endByte = pos - 1
            break
        end
    end

    return string.sub(s, startByte, endByte)
end

function replace (s, mapping)
    local pos = 1
    local bytes = string.len(s)
    local charbytes
    local newstr = ""

    while pos <= bytes do
        charbytes = charbytes(s, pos)
        local c = string.sub(s, pos, pos + charbytes - 1)
        newstr = newstr .. (mapping[c] or c)
        pos = pos + charbytes
    end

    return newstr
end