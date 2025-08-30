local packName = "Base Set"

TCG.Packs = TCG.Packs or {}

local pack = {
	id = "jungle",
    displayName = "Jungle",
	displayNameShort = "JU",
    description = "Classic Pokémon cards from the Jungle expansion.",
	cardsPerPack = 11,
	extraCardsPerPack = 0,
    rarityWeights = {
		["Rare Holo"] = 3,
		Rare = 6,
		Uncommon = 25,
		Common = 50
	},
    cardPool = {
        ["Poké Ball"] = {
            rarity = "Common", value = 1, setnumber = 64, cardType = "item"
        },
    },
	extraCardPool = {
	}
}

-- add this pack to the pool
TCG.PackPool = TCG.PackPool or {}
TCG.PackPool[pack.id] = pack