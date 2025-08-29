-- global vars
TCG = TCG or {}
TCG.PackPool = TCG.PackPool or {}

local packFiles = file.Find("tcg/packs/*.lua", "LUA")
for _, filename in ipairs(packFiles) do
    if SERVER then
        AddCSLuaFile("tcg/packs/" .. filename)
    end
    include("tcg/packs/" .. filename)
end