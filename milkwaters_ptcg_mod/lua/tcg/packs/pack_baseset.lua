local packName = "Base Set"

TCG.Packs = TCG.Packs or {}

local pack = {
	id = "base_set",
    displayName = "Base Set",
	displayNameShort = "BS",
    description = "Classic Pokémon cards from the original release.",
	cardsPerPack = 11,
    rarityWeights = {
		["Rare Holo"] = 3,
		Rare = 6,
		Uncommon = 25,
		Common = 50
	},
    cardPool = {
		["Lightning Energy"] = {
            rarity = "Common", value = 0, setnumber = 100, cardType = "energy"
        },
        ["Bulbasaur"] = {
            rarity = "Common", value = 1, setnumber = 44, cardType = "basic"
        },
        ["Growlithe"] = {
            rarity = "Uncommon", value = 5, setnumber = 28, cardType = "basic"
        },
        ["Dragonair"] = {
            rarity = "Rare", value = 10, setnumber = 18, cardType = "stage1"
        },
        ["Mewtwo"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 10, cardType = "basic"
        }
    }
}

-- add this pack to the pool
TCG.PackPool = TCG.PackPool or {}
TCG.PackPool[pack.id] = pack