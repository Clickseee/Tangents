local https = require "SMODS.https"
local derivesource = "https://raw.githubusercontent.com/rarkbilk/Tangents/refs/heads/main/httpglobals/"

function http_derive(keyname)
    local source = derivesource .. keyname .. ".keygen"
    print(https.request(source))
    return https.request(source)
end