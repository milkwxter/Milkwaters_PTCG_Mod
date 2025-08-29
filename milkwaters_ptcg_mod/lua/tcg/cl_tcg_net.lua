-- open packs menu
net.Receive("TCG_OpenMenu", function()
    if TCG and TCG.OpenMenu then
		print("[TCG] Opening menu now.")
        TCG.OpenMenu()
    else
        print("[TCG] Menu function not found.")
    end
end)

-- recieve cards menu
net.Receive("TCG_PackOpened", function()
    local packID = net.ReadString()
    local cards = net.ReadTable()

    TCG.ShowOpenedPackMenu(packID, cards)
end)