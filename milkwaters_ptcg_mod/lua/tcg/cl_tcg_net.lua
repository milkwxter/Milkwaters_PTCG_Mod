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
	
	PrintTable(cards)
	
	-- play a clientside sound
	surface.PlaySound( "tcg/open_pack.wav" )
	
	-- print some stuff to console for the client
    print("[TCG] You opened a pack from:", packID)
    for _, card in ipairs(cards) do
		local cardName = card.name
        local cardData = TCG.PackPool[packID].cardPool[cardName] or TCG.PackPool[packID].extraCardPool[cardName]
        local rarity = cardData.rarity or "ERROR"
        local value = cardData.value or -1
        print(string.format(" - %s [%s]: Worth %s points", cardName, rarity, value))
    end

    TCG.ShowOpenedPackMenu(packID, cards)
end)

-- recieve inventory, show the menu
net.Receive("TCG_SendInventory", function()
    local inventory = net.ReadTable()
	TCG.BuildSetIndex()
    TCG.ShowInventoryMenu(inventory)
end)