local https = require "SMODS.https"
local derivesource = "https://raw.githubusercontent.com/rarkbilk/Tangents/refs/heads/main/httpglobals/"

function http_derive(keyname)
    local source = derivesource .. keyname .. ".keygen"
    https.asyncRequest(source, function(code, body, headers)
        return body
    end)
end
