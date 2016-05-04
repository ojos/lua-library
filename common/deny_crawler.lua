local woothee = require "resty.woothee"

if woothee.is_crawler(ngx.var.http_user_agent) then
    ngx.log(ngx.ERR, "deny " .. ngx.var.http_user_agent)
    ngx.exit(ngx.HTTP_FORBIDDEN)
end
