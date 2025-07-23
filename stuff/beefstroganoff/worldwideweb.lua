local https = require "SMODS.https"
local derivesource = "https://raw.githubusercontent.com/rarkbilk/Tangents/refs/heads/main/httpglobals/"
local path = SMODS.current_mod.path

function http_derive(keyname)
    local source = derivesource .. keyname .. ".keygen"
    local htcode, body, header = https.request(source)
    if htcode >= 200 and htcode < 300 then -- SUCKIES
        local file = io.open(path.."httpglobals/"..keyname..".keygen", "w")
        file:write(body)
        file:close()
        return body
    else -- you failed! boooooooo
        local file = io.open(path.."httpglobals/"..keyname..".keygen", "w")
        local value = file:read()
        file:close()
        return value
    end
end