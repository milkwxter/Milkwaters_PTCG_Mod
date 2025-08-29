function TCG.GeneratePackFrom(packID)
	-- make sure the pack exists
    local pack = TCG.PackPool[packID]
    if not pack then
        print("[TCG] ERROR! Invalid pack ID:", packID)
        return {}
    end
	print("Pack chosen: " .. packID)

	-- make some lists real quick
    local result = {}
    local weightedPool = {}
	
    for cardName, cardData in pairs(pack.cardPool) do
        local rarity = cardData.rarity
        local weight = pack.rarityWeights[rarity] or 0
        for i = 1, weight do
            table.insert(weightedPool, cardName)
        end
    end
	
	-- open some cards based off the pack
    for i = 1, pack.cardsPerPack do
        local cardName = weightedPool[math.random(#weightedPool)]
        table.insert(result, cardName)
    end

	-- give the result back
    return result
end

function TCG.OpenPack(packID)
	-- get all the cards he got from the pack
    local cards = TCG.GeneratePackFrom(packID)
	
	-- give the cards to the client
	return cards
end