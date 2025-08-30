local packName = "Base Set"

TCG.Packs = TCG.Packs or {}

local pack = {
	id = "base_set",
    displayName = "Base Set",
	displayNameShort = "BS",
    description = "Classic Pokémon cards from the original release.",
	cardsPerPack = 11,
	extraCardsPerPack = 1,
    rarityWeights = {
		["Rare Holo"] = 3,
		Rare = 6,
		Uncommon = 25,
		Common = 50
	},
    cardPool = {
        ["Alakazam"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 1, cardType = "stage2"
        },
        ["Blastoise"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 2, cardType = "stage2"
        },
        ["Chansey"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 3, cardType = "basic"
        },
        ["Charizard"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 4, cardType = "stage2"
        },
        ["Mewtwo"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 10, cardType = "basic"
        },
        ["Dragonair"] = {
            rarity = "Rare", value = 10, setnumber = 18, cardType = "stage1"
        },
        ["Arcanine"] = {
            rarity = "Uncommon", value = 5, setnumber = 23, cardType = "stage1"
        },
        ["Growlithe"] = {
            rarity = "Uncommon", value = 5, setnumber = 28, cardType = "basic"
        },
        ["Bulbasaur"] = {
            rarity = "Common", value = 1, setnumber = 44, cardType = "basic"
        },
        ["Double Colorless Energy"] = {
            rarity = "Uncommon", value = 5, setnumber = 96, cardType = "specialenergy"
        },
    },
	extraCardPool = {
		["Fighting Energy"] = {
            rarity = "None", value = 0, setnumber = 97, cardType = "energy"
        },
		["Fire Energy"] = {
            rarity = "None", value = 0, setnumber = 98, cardType = "energy"
        },
		["Grass Energy"] = {
            rarity = "None", value = 0, setnumber = 99, cardType = "energy"
        },
		["Lightning Energy"] = {
            rarity = "None", value = 0, setnumber = 100, cardType = "energy"
        },
		["Psychic Energy"] = {
            rarity = "None", value = 0, setnumber = 101, cardType = "energy"
        },
		["Water Energy"] = {
            rarity = "None", value = 0, setnumber = 102, cardType = "energy"
        }
	}
}

-- add this pack to the pool
TCG.PackPool = TCG.PackPool or {}
TCG.PackPool[pack.id] = pack