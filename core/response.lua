local cjson = require "cjson"

module( "core.response", package.seeall )

function build_header()
    local origin = ngx.req.get_headers()['origin']
    if origin == nil then
        origin = '*'
    end

    ngx.header.content_type = "application/json; charset=utf-8";
    ngx.header["Access-Control-Allow-Origin"] = origin
    ngx.header["Access-Control-Allow-Credentials"] = 'true'
    ngx.header["Access-Control-Allow-Headers"] = '*'
    ngx.header["Access-Control-Allow-Methods"] = 'POST, GET, OPTIONS'
end

function error_response(code, message)
    build_header()
    ngx.status = code
    return  ngx.say(cjson.encode({code = code,
                                  message = message,
                                  servertime = tonumber(os.date("%s")),
                                  content = nil}))
end

function success_response(content, code, message)
    build_header()
    local code = code or 200
    local message = message or "OK"
    ngx.status = code
    return ngx.say(cjson.encode({code = code,
                                 message = message,
                                 servertime = tonumber(os.date("%s")),
                                 content = content}))
end
