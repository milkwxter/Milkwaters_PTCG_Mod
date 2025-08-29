local packName = "Base Set"

TCG.Packs = TCG.Packs or {}

local pack = {
	id = "base_set",
    displayName = "Base Set",
    description = "Classic Pokémon cards from the original release.",
    rarityWeights = {
		["Rare Holo"] = 3,   -- ~3%
		Rare = 6,            -- ~6%
		Uncommon = 25,       -- ~25%
		Common = 50          -- ~50%
	},
    cardPool = {
        ["Bulbasaur"] = {
            rarity = "Common", value = 1, setnumber = 44
        },
        ["Growlithe"] = {
            rarity = "Uncommon", value = 5, setnumber = 28
        },
        ["Dragonair"] = {
            rarity = "Rare", value = 10, setnumber = 18
        },
        ["Mewtwo"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 10
        }
    }
}

-- add this pack to the pool
TCG.PackPool = TCG.PackPool or {}
TCG.PackPool[pack.id] = pack