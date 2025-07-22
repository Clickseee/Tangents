local https = require "SMODS.https"
local derivesource = "https://raw.githubusercontent.com/rarkbilk/Tangents/refs/heads/main/httpglobals/"

function http_derive(keyname)
    local source = derivesource .. keyname .. ".keygen"
    local code, body, header = https.request(source)
    return body
end
