print("[TCG] Chat hook loaded.")

hook.Add("PlayerSay", "TCG_ChatCommand", function(ply, text)
    if string.lower(text) == "/tcg" then
		print(ply:Nick())
        net.Start("TCG_OpenMenu")
        net.Send(ply)
        return ""
    end
end)