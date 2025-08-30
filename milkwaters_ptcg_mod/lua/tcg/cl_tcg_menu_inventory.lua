local function sortInventory(inventory, mode)
    table.sort(inventory, function(a, b)
        local packA = TCG.PackPool[a.packid]
        local packB = TCG.PackPool[b.packid]
        local entryA = TCG.SetIndex[a.packid] and TCG.SetIndex[a.packid][tonumber(a.setnumber)]
        local entryB = TCG.SetIndex[b.packid] and TCG.SetIndex[b.packid][tonumber(b.setnumber)]

        if not entryA or not entryB then return false end

        if mode == "Card Identifier" then
			local shortA = (packA.displayNameShort or "")
			local shortB = (packB.displayNameShort or "")
			local numA = tonumber(a.setnumber)
			local numB = tonumber(b.setnumber)

			if shortA == shortB then
				return numA < numB
			else
				return shortA < shortB
			end
        elseif mode == "Card Name" then
            return entryA.name < entryB.name
        elseif mode == "Card Quantity" then
            return tonumber(a.quantity) > tonumber(b.quantity)
        elseif mode == "Card Rarity" then
            local weightA = packA.rarityWeights[entryA.data.rarity] or 0
            local weightB = packB.rarityWeights[entryB.data.rarity] or 0
            return weightA < weightB
        end

        return false
    end)
end

function TCG.BuildSetIndex()
    TCG.SetIndex = {}

    for packID, pack in pairs(TCG.PackPool) do
        TCG.SetIndex[packID] = {}

        for name, card in pairs(pack.cardPool) do
            if card.setnumber then
                TCG.SetIndex[packID][card.setnumber] = { name = name, data = card }
            end
        end

        for name, card in pairs(pack.extraCardPool or {}) do
            if card.setnumber then
                TCG.SetIndex[packID][card.setnumber] = { name = name, data = card }
            end
        end
    end

    print("[TCG] SetIndex built for fast inventory lookup.")
end

function TCG.ShowInventoryMenu(inventory)
    local frame = vgui.Create("DFrame")
    frame:SetTitle(LocalPlayer():Nick() .. "'s Card Inventory")
    frame:SetSize(800, 600)
    frame:Center()
    frame:MakePopup()

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)
	
	local sortDropdown = vgui.Create("DComboBox", scroll)
	sortDropdown:SetPos(50, 0)
	sortDropdown:SetSize(200, 25)
	sortDropdown:Dock(TOP)
	sortDropdown:DockMargin(10, 10, 10, 0)
	sortDropdown:SetValue("Sort By")
	
	sortDropdown:AddChoice("Card Identifier")
	sortDropdown:AddChoice("Card Name")
	sortDropdown:AddChoice("Card Quantity")
	sortDropdown:AddChoice("Card Rarity")
	
	sortDropdown.OnSelect = function(_, _, selected)
		sortInventory(inventory, selected)
		 -- re-render with sorted data
		frame:Close()
		TCG.ShowInventoryMenu(inventory)
	end

    local grid = vgui.Create("DIconLayout", scroll)
    grid:Dock(FILL)
    grid:SetSpaceX(10)
    grid:SetSpaceY(10)
    grid:DockMargin(10, 10, 10, 10)
	
    if not inventory then
        local label = vgui.Create("DLabel", scroll)
        label:SetText("No cards found.")
        label:SetFont("DermaLarge")
        label:SetTextColor(color_white)
        label:Dock(TOP)
        label:DockMargin(10, 10, 10, 10)
        return
    end

    for _, entry in ipairs(inventory) do
        local packID = entry.packid
        local setNumber = tonumber(entry.setnumber)
        local quantity = tonumber(entry.quantity)

        local cardEntry = TCG.SetIndex[packID] and TCG.SetIndex[packID][setNumber]
		if not cardEntry then continue end

        local cardData = cardEntry.data
		local cardName = cardEntry.name

        if not cardData then continue end

        local matPath = "cards/" .. packID .. "/" .. setNumber .. ".png"
		
		local cardIdentifier = TCG.PackPool[packID].displayNameShort .. setNumber

        local cardPanel = grid:Add("DPanel")
        cardPanel:SetSize(140, 200)

        cardPanel.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(35, 35, 50))
			draw.SimpleText(cardName, "DermaDefault", 10, 140, color_white)
			draw.SimpleText("ID: " .. cardIdentifier, "DermaDefault", 10, 155, color_white)
			draw.SimpleText("Qty: " .. quantity, "DermaDefaultBold", 10, 170, Color(200, 255, 200))
        end

        local cardImage = vgui.Create("DImage", cardPanel)
        cardImage:SetSize(128, 128)
        cardImage:SetPos(6, 6)
        cardImage:SetImage(matPath)
    end
end
