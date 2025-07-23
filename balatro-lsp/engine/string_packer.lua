--- @meta

--- Packs string so it can be loaded
--- @param data table Table data
--- @param recursive? boolean
--- @return string
function STR_PACK(data, recursive) end

--- Loads table data
--- @param str string
--- @return table
function STR_UNPACK(str) end

--- Gets deflare-compressed file data. Returns nil if decompress failed
--- @param file string
--- @return string | nil
function get_compressed(file) end

--- Compresses and saves data to a file.
--- If data is a type of table, it will be converted to string via `STR_PACK` first.
--- @param file string
--- @param data string | table
function compress_and_save(file, data) end

