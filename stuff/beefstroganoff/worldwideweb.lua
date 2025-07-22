local https = require "SMODS.https"
local derivesource = "https://raw.githubusercontent.com/rarkbilk/Tangents/refs/heads/main/httpglobals/"

function http_derive(keyname)
    local source = derivesource .. keyname .. ".keygen"
    local value = 44
    https.asyncRequest(source, function(code, body, headers)
        value = body
    end)
    return value
end
