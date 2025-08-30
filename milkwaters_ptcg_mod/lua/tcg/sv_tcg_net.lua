-- menu
util.AddNetworkString("TCG_OpenMenu")

-- pack opening
util.AddNetworkString("TCG_RequestOpenPack")
util.AddNetworkString("TCG_PackOpened")

-- inventory
util.AddNetworkString("TCG_RequestInventory")
util.AddNetworkString("TCG_SendInventory")

----------------------------------------------

-- player wants to open pack
net.Receive("TCG_RequestOpenPack", function(len, ply)
    local packID = net.ReadString()
    local pack = TCG.PackPool[packID]

    if not pack then
        print("[TCG] Invalid pack ID from", ply:Nick())
        return
    end

    -- TODO: check if he is allowed to open the pack

	-- get his cards
    local cards = TCG.OpenPack(packID)
	
	-- register them to his SQL DB entry
	for _, cardName in ipairs(cards) do
		local card = pack.cardPool[cardName] or pack.extraCardPool[cardName]
		if card and card.setnumber then
			TCG.AddCardToInventory(ply, packID, card.setnumber)
		end
	end

    -- send results to client
    net.Start("TCG_PackOpened")
    net.WriteString(packID)
    net.WriteTable(cards)
    net.Send(ply)

    print("[TCG] Pack opened for", ply:Nick(), "→", table.concat(cards, ", "))
end)