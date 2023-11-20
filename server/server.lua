local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

lak = {}
Tunnel.bindInterface("lak_first",lak)
Proxy.addInterface("lak_first",lak)

vCLIENT = Tunnel.getInterface("lak_first")
local cfg = module("lak_first","config")

local func = exports["vrp"]

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("lak/InfosInvestigacao", "SELECT * FROM lak_investigacao WHERE user_id = @user_id")
vRP._prepare("lak/InsertInvestigacao", "INSERT INTO lak_investigacao(user_id, rc, level, exp) VALUES(@user_id, @rc, @level, @exp)") 
vRP._prepare("lak/UpdateEXPInvesticao","UPDATE lak_investigacao SET exp = exp + @exp WHERE user_id = @user_id")
vRP._prepare("lak/UpdateEXP2Investigacao", "UPDATE lak_investigacao SET level = level + @level, exp = @exp WHERE user_id = @user_id") 
vRP._prepare("lak/UpdateEXP3Investigacao", "UPDATE lak_investigacao SET rc = rc + @rc WHERE user_id = @user_id") 

vRP._prepare("lak/lak_investigacao", [[
    CREATE TABLE IF NOT EXISTS lak_investigacao(
        user_id INTEGER,
		mc INTEGER, 
        level INTEGER,
        exp INTEGER,
        PRIMARY KEY (`user_id`) USING BTREE
    )
]])
-- mc = Missões completas

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end 

-----------------------------------------------------------------------------------------------------------------------------------------
-- Setar lvl 0 desde que entra
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
		
        	local infos = vRP.query("lak/InfosInvestigacao", {
            	user_id = parseInt(user_id)
        	})

        	if infos[1] == nil then

            vRP.query("lak/InsertInvestigacao", {
                user_id = parseInt(user_id),
                mc = 0,
				level = 1,
				exp = 0,
            })

        end
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[function lak.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tomate")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"tomate",quantidade[source])
		quantidade[source] = nil
		return true
		end
	end
end--]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- Checkar level
-----------------------------------------------------------------------------------------------------------------------------------------
lak.CheckLevel = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local player = vRP.query("lak/InfosInvestigacao", {user_id = user_id})
		return player[1].mc,player[1].level,player[1].exp
	end
end