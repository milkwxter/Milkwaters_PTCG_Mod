print("[TCG] Client TCG loaded:", istable(TCG), "Pack count:", table.Count(TCG.PackPool or {}))

if CLIENT then
    print("[TCG] cl_tcg_menu.lua loaded on client.")
end

function TCG.OpenMenu()
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Pokémon TCG")
    frame:SetSize(600, 400)
    frame:Center()
    frame:MakePopup()

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

    for packID, pack in pairs(TCG.PackPool) do
        local cardCount = table.Count(pack.cardPool)

        local entry = scroll:Add("DPanel")
        entry:Dock(TOP)
        entry:SetTall(100)
        entry:DockMargin(0, 0, 0, 10)

        entry.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60))
            draw.SimpleText(pack.displayName, "DermaLarge", 10, 10, color_white, TEXT_ALIGN_LEFT)
            draw.SimpleText(pack.description, "DermaDefault", 10, 35, color_white, TEXT_ALIGN_LEFT)
            draw.SimpleText("Cards: " .. cardCount, "DermaDefault", 10, 55, color_white, TEXT_ALIGN_LEFT)
        end

        local openBtn = vgui.Create("DButton", entry)
        openBtn:SetText("Open Pack")
        openBtn:SetSize(100, 30)
        openBtn:SetPos(480, 60)

        openBtn.DoClick = function()
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
        frame:SetSize(400, 300)
        frame:Center()
        frame:MakePopup()

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)

        for _, cardName in ipairs(cards) do
            local card = pack.cardPool[cardName]

            local entry = scroll:Add("DPanel")
            entry:Dock(TOP)
            entry:SetTall(60)
            entry:DockMargin(0, 0, 0, 5)

            entry.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 50))
                draw.SimpleText(cardName, "DermaLarge", 10, 5, color_white, TEXT_ALIGN_LEFT)
                draw.SimpleText("Rarity: " .. (card.rarity or "Unknown"), "DermaDefault", 10, 30, color_white, TEXT_ALIGN_LEFT)
            end
        end
    end

    local function showCardReveal(index)
        local cardName = cards[index]
        local card = pack.cardPool[cardName]

        local frame = vgui.Create("DFrame")
		local frameW = 800
		local frameH = 400
        frame:SetTitle("Card " .. index .. " of " .. #cards)
        frame:SetSize(frameW, frameH)
        frame:Center()
        frame:MakePopup()

        frame.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60))
        end
		
		if card.setnumber then
			local matString = "materials/cards/" .. pack.id .. "/" .. card.setnumber .. ".png"
			
			local cardImage = vgui.Create("DImage", frame)
			cardImage:SetSize(400, 400)
			cardImage:SetPos(frame:GetWide() - 20 - cardImage:GetWide(), 10)
			cardImage:SetImage(matString)
		end

        local nameLabel = vgui.Create("DLabel", frame)
        nameLabel:SetText(cardName)
        nameLabel:SetFont("DermaLarge")
        nameLabel:SetTextColor(color_white)
        nameLabel:SizeToContents()
        nameLabel:SetPos(20, 40)

        local rarityLabel = vgui.Create("DLabel", frame)
        rarityLabel:SetText("Rarity: " .. (card.rarity or "Unknown"))
        rarityLabel:SetFont("DermaDefault")
        rarityLabel:SetTextColor(color_white)
        rarityLabel:SizeToContents()
        rarityLabel:SetPos(20, 80)

        local nextBtn = vgui.Create("DButton", frame)
        nextBtn:SetText(index < #cards and "Next Card" or "Finish")
        nextBtn:SetSize(100, 30)
        nextBtn:SetPos(20, 130)

        nextBtn.DoClick = function()
            frame:Close()
            if index < #cards then
                showCardReveal(index + 1)
            else
				frame:Close()
                showFullPackSummary()
            end
        end

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

