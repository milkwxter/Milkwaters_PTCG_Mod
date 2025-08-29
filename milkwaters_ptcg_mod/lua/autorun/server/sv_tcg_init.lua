-- server stuff
if SERVER then
	print("[TCG] Loaded: sh_tcg_init.lua")

	-- send shared and client files
	AddCSLuaFile("tcg/sh_tcg_core.lua")
	AddCSLuaFile("tcg/cl_tcg_menu.lua")
	AddCSLuaFile("tcg/cl_tcg_net.lua")

	-- load CORE first
	include("tcg/sh_tcg_core.lua")

	-- now its safe to load the rest
	include("tcg/sv_tcg_packhelper.lua")
	include("tcg/sv_tcg_chat.lua")
	include("tcg/sv_tcg_net.lua")
end