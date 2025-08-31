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
        ["Clefairy"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 5, cardType = "basic"
        },
        ["Gyarados"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 6, cardType = "stage1"
        },
        ["Hitmonchan"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 7, cardType = "basic"
        },
        ["Machamp"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 8, cardType = "stage2"
        },
        ["Magneton"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 9, cardType = "stage1"
        },
        ["Mewtwo"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 10, cardType = "basic"
        },
        ["Nidoking"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 11, cardType = "stage2"
        },
        ["Ninetales"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 12, cardType = "stage1"
        },
        ["Poliwrath"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 13, cardType = "stage2"
        },
        ["Raichu"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 14, cardType = "stage1"
        },
        ["Venusaur"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 15, cardType = "stage2"
        },
        ["Zapdos"] = {
            rarity = "Rare Holo", value = 1000, setnumber = 16, cardType = "basic"
        },
        ["Beedrill"] = {
            rarity = "Rare", value = 10, setnumber = 17, cardType = "stage2"
        },
        ["Dragonair"] = {
            rarity = "Rare", value = 10, setnumber = 18, cardType = "stage1"
        },
        ["Dugtrio"] = {
            rarity = "Rare", value = 10, setnumber = 19, cardType = "stage1"
        },
        ["Electabuzz"] = {
            rarity = "Rare", value = 10, setnumber = 20, cardType = "basic"
        },
        ["Electrode"] = {
            rarity = "Rare", value = 10, setnumber = 21, cardType = "stage1"
        },
        ["Pidgeotto"] = {
            rarity = "Rare", value = 10, setnumber = 22, cardType = "stage1"
        },
        ["Arcanine"] = {
            rarity = "Uncommon", value = 5, setnumber = 23, cardType = "stage1"
        },
        ["Charmeleon"] = {
            rarity = "Uncommon", value = 5, setnumber = 24, cardType = "stage1"
        },
        ["Dewgong"] = {
            rarity = "Uncommon", value = 5, setnumber = 25, cardType = "stage1"
        },
        ["Dratini"] = {
            rarity = "Uncommon", value = 5, setnumber = 26, cardType = "basic"
        },
        ["Farfetch'd"] = {
            rarity = "Uncommon", value = 5, setnumber = 27, cardType = "basic"
        },
        ["Growlithe"] = {
            rarity = "Uncommon", value = 5, setnumber = 28, cardType = "basic"
        },
        ["Haunter"] = {
            rarity = "Uncommon", value = 5, setnumber = 29, cardType = "stage1"
        },
        ["Ivysaur"] = {
            rarity = "Uncommon", value = 5, setnumber = 30, cardType = "stage1"
        },
        ["Jynx"] = {
            rarity = "Uncommon", value = 5, setnumber = 31, cardType = "basic"
        },
        ["Kadabra"] = {
            rarity = "Uncommon", value = 5, setnumber = 32, cardType = "stage1"
        },
        ["Kakuna"] = {
            rarity = "Uncommon", value = 5, setnumber = 33, cardType = "stage1"
        },
        ["Machoke"] = {
            rarity = "Uncommon", value = 5, setnumber = 34, cardType = "stage1"
        },
        ["Magikarp"] = {
            rarity = "Uncommon", value = 5, setnumber = 35, cardType = "basic"
        },
        ["Magmar"] = {
            rarity = "Uncommon", value = 5, setnumber = 36, cardType = "basic"
        },
        ["Nidorino"] = {
            rarity = "Uncommon", value = 5, setnumber = 37, cardType = "stage1"
        },
        ["Poliwhirl"] = {
            rarity = "Uncommon", value = 5, setnumber = 38, cardType = "stage1"
        },
        ["Porygon"] = {
            rarity = "Uncommon", value = 5, setnumber = 39, cardType = "basic"
        },
        ["Raticate"] = {
            rarity = "Uncommon", value = 5, setnumber = 40, cardType = "stage1"
        },
        ["Seel"] = {
            rarity = "Uncommon", value = 5, setnumber = 41, cardType = "basic"
        },
        ["Wartortle"] = {
            rarity = "Uncommon", value = 5, setnumber = 42, cardType = "stage1"
        },
        ["Abra"] = {
            rarity = "Common", value = 5, setnumber = 43, cardType = "basic"
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