-- set up the database when game starts if it doesnt exist
hook.Add("Initialize", "TCG_InventorySetup", function()
    if not sql.TableExists("tcg_inventory") then
        sql.Query([[
            CREATE TABLE tcg_inventory (
                steamid TEXT,
                packid TEXT,
                setnumber INTEGER,
                quantity INTEGER
            )
        ]])
        print("[TCG] Inventory table created.")
    else
        print("[TCG] Inventory table already exists.")
    end
end)

-- here is where I add cards to your collection
function TCG.AddCardToInventory(ply, packID, setNumber)
    local steamID = ply:SteamID()
    local query = string.format(
        "SELECT quantity FROM tcg_inventory WHERE steamid = '%s' AND packid = '%s' AND setnumber = %d",
        steamID, packID, setNumber
    )

    local result = sql.QueryValue(query)

    if result then
        sql.Query(string.format(
            "UPDATE tcg_inventory SET quantity = quantity + 1 WHERE steamid = '%s' AND packid = '%s' AND setnumber = %d",
            steamID, packID, setNumber
        ))
    else
        sql.Query(string.format(
            "INSERT INTO tcg_inventory (steamid, packid, setnumber, quantity) VALUES ('%s', '%s', %d, 1)",
            steamID, packID, setNumber
        ))
    end
end

-- return a players collection
function TCG.GetInventory(ply)
    local steamID = ply:SteamID()
    return sql.Query("SELECT * FROM tcg_inventory WHERE steamid = '" .. steamID .. "'")
end

-- return how many of a certain card a player owns
function TCG.GetCardQuantity(ply, packID, setNumber)
	-- safety debug
	if not ply or not packID or not setNumber then
        print("[TCG] GetCardQuantity: Missing argument(s)", ply, packID, setNumber)
        return 0
    end
	
    local steamID = ply:SteamID()
    local query = string.format(
        "SELECT quantity FROM tcg_inventory WHERE steamid = '%s' AND packid = '%s' AND setnumber = %d",
        steamID, packID, setNumber
    )

    local result = sql.QueryValue(query)
    return tonumber(result) or 0
end


-- when a player asks for their inventory, give it to them
net.Receive("TCG_RequestInventory", function(len, ply)
    local inventory = TCG.GetInventory(ply)

    net.Start("TCG_SendInventory")
    net.WriteTable(inventory or {})
    net.Send(ply)
end)
