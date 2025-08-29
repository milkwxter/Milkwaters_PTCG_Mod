function TCG.ReloadPacks()
    TCG.PackPool = {}

    local packFiles = file.Find("tcg/packs/*.lua", "LUA")
    for _, filename in ipairs(packFiles) do
        include("tcg/packs/" .. filename)
        print("[TCG] Reloaded pack:", filename)
    end
end

concommand.Add("tcg_reloadpacks", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsAdmin() then return end
    TCG.ReloadPacks()
    print("[TCG] Packs reloaded by", IsValid(ply) and ply:Nick() or "console")
end)