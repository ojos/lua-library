local string = require "string"
local table = require "table"

module( "core.request", package.seeall )

function encode(str)
    if str then
        str = string.gsub(str, "\n", "\r\n")
        str = string.gsub(str, "([^%w ])",
                          function(c) return string.format("%%%02X", string.byte(c)) end)
        str = string.gsub(str, " ", "+")
    end
    return str
end

function urlencode(t)
    local args = {}
    local i = 1
    for k, v in pairs(t) do
        args[i] = encode(k) .. "=" .. encode(v)
        i = i + 1
    end
    return table.concat(args,'&')
end