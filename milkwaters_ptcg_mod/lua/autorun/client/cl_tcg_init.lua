-- le client
if CLIENT then
	print("[TCG] Loaded: sh_tcg_init.lua")

	-- send shared and client files
	include("tcg/sh_tcg_core.lua")
	include("tcg/cl_tcg_menu.lua")
	include("tcg/cl_tcg_net.lua")
end