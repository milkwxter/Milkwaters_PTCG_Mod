function TCG.GeneratePackFrom(packID)
    local pack = TCG.PackPool[packID]
    if not pack then
        print("[TCG] ERROR! Invalid pack ID:", packID)
        return {}
    end
	print("Pack chosen: " .. packID)

    local result = {}
    local weightedPool = {}
	local numCards = table.Count(pack.cardPool)
	
	print("# of cards: " .. numCards)
    for cardName, cardData in pairs(pack.cardPool) do
        local rarity = cardData.rarity
        local weight = pack.rarityWeights[rarity] or 0
        for i = 1, weight do
            table.insert(weightedPool, cardName)
        end
    end
	
    for i = 1, 10 do
        local cardName = weightedPool[math.random(#weightedPool)]
        table.insert(result, cardName)
    end

    return result
end

function TCG.OpenPack(packID)
	-- get all the cards he got from the pack
    local cards = TCG.GeneratePackFrom(packID)
	
	-- print some stuff to console
    print("[TCG] You opened a pack from:", packID)
    for _, cardName in ipairs(cards) do
        local cardData = TCG.PackPool[packID].cardPool[cardName]
        local rarity = cardData.rarity or "ERROR"
        local value = cardData.value or -1
        print(string.format(" - %s [%s]: Worth %s points", cardName, rarity, value))
    end
	
	-- give the cards to the client
	return cards
end