print("[TCG] Client TCG loaded:", istable(TCG), "Pack count:", table.Count(TCG.PackPool or {}))

if CLIENT then
    print("[TCG] cl_tcg_menu.lua loaded on client.")
end

function TCG.OpenMenu()
	-- create the main frame (lol)
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Milkwater's TCG Mod")
    frame:SetSize(600, 400)
    frame:Center()
    frame:MakePopup()
	
	-- top bar for buttons and lables
	local topBar = vgui.Create("DPanel", frame)
	topBar:Dock(TOP)
	topBar:SetTall(40)
	topBar:DockMargin(0, 0, 0, 5)
	topBar.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60))
	end
	
	-- some buttons
	local btnWidth = 100
	local btnSpacing = 10
	local btnY = 5

	local collectionBtn = vgui.Create("DButton", topBar)
	collectionBtn:SetText("Collection")
	collectionBtn:SetSize(btnWidth, 30)
	collectionBtn:SetPos(10, btnY)

	local sellBtn = vgui.Create("DButton", topBar)
	sellBtn:SetText("Sell")
	sellBtn:SetSize(btnWidth, 30)
	sellBtn:SetPos(10 + btnWidth + btnSpacing, btnY)

	local tradeBtn = vgui.Create("DButton", topBar)
	tradeBtn:SetText("Trade")
	tradeBtn:SetSize(btnWidth, 30)
	tradeBtn:SetPos(10 + (btnWidth + btnSpacing) * 2, btnY)
	
	-- player balance label
	-- TODO: Add money system
	local balanceLabel = vgui.Create("DLabel", topBar)
	balanceLabel:SetText(LocalPlayer():Nick() .. "'s balance: " .. 0)
	balanceLabel:SetFont("DermaDefaultBold")
	balanceLabel:SetTextColor(color_white)
	balanceLabel:SizeToContents()
	balanceLabel:SetPos(tradeBtn:GetX() + tradeBtn:GetWide() + btnSpacing, btnY + 7)

	-- create the scroller for pack opening
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

	-- create all the pack entries
    for packID, pack in pairs(TCG.PackPool) do
        local cardCount = table.Count(pack.cardPool)

        local entry = scroll:Add("DPanel")
        entry:Dock(TOP)
        entry:SetTall(100)
        entry:DockMargin(0, 0, 0, 10)

        entry.Paint = function(self, w, h)
			-- paint tha box
            draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60))
			
			-- do a pack picture
			local matString = "materials/packs/" .. pack.id .. ".png"
			local packImage = vgui.Create("DImage", entry)
			packImage:SetSize(150, 150)
			packImage:SetPos(-30, -25)
			packImage:SetImage(matString)
			
			-- draw stats of pack
            draw.SimpleText(pack.displayName, "DermaLarge", 15 + packImage:GetWide(), 5, color_white, TEXT_ALIGN_LEFT)
            draw.SimpleText(pack.description, "DermaDefault", 15 + packImage:GetWide(), 35, color_white, TEXT_ALIGN_LEFT)
            draw.SimpleText("Total cards in this set: " .. (cardCount or "Unknown"), "DermaDefault", 15 + packImage:GetWide(), 55, color_white, TEXT_ALIGN_LEFT)
            draw.SimpleText("Cards per pack: " .. (pack.cardsPerPack or "Unknown"), "DermaDefault", 15 + packImage:GetWide(), 75, color_white, TEXT_ALIGN_LEFT)
        end

		-- here is how you open a pack
        local openBtn = vgui.Create("DButton", entry)
        openBtn:SetText("Open Pack")
        openBtn:SetSize(100, 30)
        openBtn:SetPos(480, 60)
        openBtn.DoClick = function()
			-- send message to the SERVER to ask if the player is allowed to open the pack
			net.Start("TCG_RequestOpenPack")
			net.WriteString(packID)
			net.SendToServer()
		end
    end
end

function TCG.ShowOpenedPackMenu(packID, cards)
    local pack = TCG.PackPool[packID]
    if not pack then
        print("[TCG] ERROR: Pack not found:", packID)
        return
    end

    local currentIndex = 1

	local function showFullPackSummary()
        local frame = vgui.Create("DFrame")
        frame:SetTitle("Pack Opened: " .. (pack.displayName or packID))
        frame:SetSize(400, 400)
        frame:Center()
        frame:MakePopup()
		
		-- summary panel AT THE BOTTOM
		local summaryPanel = vgui.Create("DScrollPanel", frame)
		summaryPanel:Dock(BOTTOM)
		summaryPanel:SetTall(120)
		summaryPanel:DockMargin(0, 5, 0, 0)
		summaryPanel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 40))
		end

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)
		
		-- track some stats about your cards
		local rarityCount = {}
		local totalValue = 0

        for _, cardName in ipairs(cards) do
            local card = pack.cardPool[cardName]
			
			-- increment local stats
			local rarity = card.rarity or "Unknown"
			rarityCount[rarity] = (rarityCount[rarity] or 0) + 1
			totalValue = totalValue + (card.value or 0)

            local entry = scroll:Add("DPanel")
            entry:Dock(TOP)
            entry:SetTall(60)
            entry:DockMargin(0, 0, 0, 5)

            entry.Paint = function(self, w, h)
				-- paint the box
                draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 50))
				
				local matString = "materials/cards/" .. pack.id .. "/" .. card.setnumber .. ".png"
				local cardImage = vgui.Create("DImage", entry)
				cardImage:SetSize(50, 50)
				cardImage:SetPos(0, 5)
				cardImage:SetImage(matString)
				
				-- draw some simple text
                draw.SimpleText(cardName .. " - " .. pack.displayNameShort .. "#" .. card.setnumber, "DermaDefaultBold", cardImage:GetWide() + 10, 5, color_white, TEXT_ALIGN_LEFT)
                draw.SimpleText("Rarity: " .. (card.rarity or "Unknown"), "DermaDefault", cardImage:GetWide() + 10, 30, color_white, TEXT_ALIGN_LEFT)
            end
        end
		
		-- display the stats at the end
		local valueLabel = vgui.Create("DLabel", summaryPanel)
		valueLabel:SetText("Estimated Total Value: " .. totalValue .. " points")
		valueLabel:SetFont("DermaDefaultBold")
		valueLabel:SetTextColor(color_white)
		valueLabel:Dock(TOP)
		valueLabel:DockMargin(10, 5, 10, 0)
		
		for rarity, count in pairs(rarityCount) do
			local rarityLabel = vgui.Create("DLabel", summaryPanel)
			rarityLabel:SetText(rarity .. ": " .. count)
			rarityLabel:SetFont("DermaDefault")
			rarityLabel:SetTextColor(color_white)
			rarityLabel:Dock(TOP)
			rarityLabel:DockMargin(10, 2, 10, 0)
		end
    end

    local function showCardReveal(index)
		-- save stats of the card you are revealing
        local cardName = cards[index]
        local card = pack.cardPool[cardName]
		
		-- list of sounds
		local soundList = {
			"tcg/card_reveal_1.wav",
			"tcg/card_reveal_2.wav",
			"tcg/card_reveal_3.wav"
		}

		-- create a frame to hold the GUI
        local frame = vgui.Create("DFrame")
		local frameW = 800
		local frameH = 400
        frame:SetTitle("Card " .. index .. " of " .. #cards)
        frame:SetSize(frameW, frameH)
        frame:Center()
        frame:MakePopup()

		-- paint it a nice color
        frame.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60))
        end
		
		-- show an image of the card
		local matString = "materials/cards/" .. pack.id .. "/" .. card.setnumber .. ".png"
		local cardImage = vgui.Create("DImage", frame)
		cardImage:SetSize(400, 400)
		cardImage:SetPos(frame:GetWide() - 20 - cardImage:GetWide(), 10)
		cardImage:SetImage(matString)

		-- learn the name of the card
        local nameLabel = vgui.Create("DLabel", frame)
        nameLabel:SetText(cardName .. " - " .. pack.displayNameShort .. "#" .. card.setnumber)
        nameLabel:SetFont("DermaLarge")
        nameLabel:SetTextColor(color_white)
        nameLabel:SizeToContents()
        nameLabel:SetPos(20, 40)

		-- learn the rarity of the card
        local rarityLabel = vgui.Create("DLabel", frame)
        rarityLabel:SetText("Rarity: " .. (card.rarity or "Unknown"))
        rarityLabel:SetFont("DermaDefault")
        rarityLabel:SetTextColor(color_white)
        rarityLabel:SizeToContents()
        rarityLabel:SetPos(20, 80)

		-- make a button to go to the next card OR finish, depends on the logic
        local nextBtn = vgui.Create("DButton", frame)
        nextBtn:SetText(index < #cards and "Next Card" or "Finish")
        nextBtn:SetSize(100, 30)
        nextBtn:SetPos(20, 130)
        nextBtn.DoClick = function()
            frame:Close()
            if index < #cards then
                showCardReveal(index + 1)
				
				-- play a RANDOM clientside sound for variety
				local randomSound = soundList[math.random(#soundList)]
				surface.PlaySound(randomSound)
            else
				frame:Close()
                showFullPackSummary()
            end
        end

		-- create a instant skip button for impatient guys
        local skipBtn = vgui.Create("DButton", frame)
        skipBtn:SetText("Skip to Results")
        skipBtn:SetSize(120, 30)
        skipBtn:SetPos(140, 130)
        skipBtn.DoClick = function()
            frame:Close()
            showFullPackSummary()
        end
    end

    -- Start with first card
    showCardReveal(currentIndex)
end

