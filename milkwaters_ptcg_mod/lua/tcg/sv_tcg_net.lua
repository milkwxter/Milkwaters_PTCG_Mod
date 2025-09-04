-- menu
util.AddNetworkString("TCG_OpenMenu")

-- pack opening
util.AddNetworkString("TCG_RequestOpenPack")
util.AddNetworkString("TCG_PackOpened")

-- inventory
util.AddNetworkString("TCG_RequestInventory")
util.AddNetworkString("TCG_SendInventory")

-- client requests card amount for various stuff
util.AddNetworkString("TCG_RequestCardQuantity")
util.AddNetworkString("TCG_SendCardQuantity")

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
    local rawCards = TCG.OpenPack(packID)
	local cards = {}
	
	-- register them to his SQL DB entry
	for _, cardName in ipairs(rawCards) do
		-- get the card and make sure its valid
		local card = pack.cardPool[cardName] or pack.extraCardPool[cardName]
		if not card and not card.setnumber then continue end
		
		-- append extra data to say if the card is new or not
		local quantity = TCG.GetCardQuantity(ply, packID, card.setnumber)
		local hasCard = (quantity == 0)
		
		-- if valid, add to SQL database for player
		TCG.AddCardToInventory(ply, packID, card.setnumber)
		
		-- add to the cards table
		table.insert(cards, {
			name = cardName,
			new = hasCard
		})
	end

    -- send results to client
    net.Start("TCG_PackOpened")
    net.WriteString(packID)
    net.WriteTable(cards)
    net.Send(ply)

    print("[TCG] Pack opened for", ply:Nick())
end)

-- when a player asks for their amount of a card, give it to them
net.Receive("TCG_RequestCardQuantity", function(len, ply)
    local packID = net.ReadString()
    local setNumber = net.ReadInt(16)

    local quantity = TCG.GetCardQuantity(ply, packID, setNumber)
	print(ply:Nick() .. " HAS " .. quantity .. " QUANTITY OF WHATEVER CARD!")

    net.Start("TCG_SendCardQuantity")
    net.WriteInt(quantity, 16)
    net.Send(ply)
end)