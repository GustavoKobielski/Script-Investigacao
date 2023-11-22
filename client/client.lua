local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

lak = {}
Tunnel.bindInterface("lak_first",lak)
vSERVER = Tunnel.getInterface("lak_first")

-----------------------------------------------------------------------------------------------------------------------------------------
-- Variaveis
-----------------------------------------------------------------------------------------------------------------------------------------
local servico = false
local npcs = {}
local text = {}
local selectedMission = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- Iniciar trampo com blip
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if cfg.useBlip then
			if not servico then
				local ped = PlayerPedId()
				local playercoords = GetEntityCoords(ped)
				local vida = GetEntityHealth(ped)

				for k,v in pairs(cfg.locWork) do
					local distance = #(playercoords - v)
					if distance <= 40.0 then
						time = 5
						cfg.drawMarker(v)
						if distance <= 2.0 then
							cfg.drawTxt(v)
							if IsControlJustPressed(0, cfg.botaoTrabalho) then
                                servico = true
                                selectedMission = SelectRandomMission()
                                if selectedMission then
                                    print("Missão selecionada: " .. selectedMission)
                                    CreateNPC(selectedMission) -- Passe o índice da missão selecionada como argumento
                                else
                                    print("Nenhuma missão disponível.")
                                end
                                TriggerEvent("Notify", "sucesso", "Você entrou em serviço.", 5000)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Iniciar trampo com NUI
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if cfg.useNui then
			if not servico then
				local ped = PlayerPedId()
				local playercoords = GetEntityCoords(ped)
				local vida = GetEntityHealth(ped)

				for k,v in pairs(cfg.locWork) do
					local distance = #(playercoords - v)
					if distance <= 40.0 then
						time = 5
						cfg.drawMarker(v)
						if distance <= 2.0 then
							if IsControlJustPressed(0,cfg.botaoTrabalho) then
								local mc,level,exp = vSERVER.CheckLevel()
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showMenu", mc = mc, level = level, exp = exp, exp_por_level = exp_por_level, quantidade_de_blips = quantidade_de_blips })
								StartScreenEffect("MenuMGSelectionIn", 0, true)
							end
                        end
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Close painel
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	--invOpen = false
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,168) then
				TriggerEvent("Notify", "sucesso", "Você saiu de serviço.", 5000)
				servico = false
				SetNuiFocus(false,false)
				SendNUIMessage({ action = "hideMenu" })
				StopScreenEffect("MenuMGSelectionIn")
				DeleteAllNPCs()
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Selecionar missão aleatoria
-----------------------------------------------------------------------------------------------------------------------------------------
function SelectRandomMission()
    local numMissions = #cfg.Casos
    if numMissions > 0 then
        local randomIndex = math.random(numMissions)
        return randomIndex
    else
        return nil
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Trabalho
-----------------------------------------------------------------------------------------------------------------------------------------
function investigacaoStart()
	Citizen.CreateThread(function()
		while servico do
			local timing = 1000
		
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
				local veh = GetVehiclePedIsIn(PlayerPedId(),false)

				CreateNPC()
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Função para mostrar o texto aleatório
-----------------------------------------------------------------------------------------------------------------------------------------
function showDialog(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Função para conversar com o npc
-----------------------------------------------------------------------------------------------------------------------------------------
-- local Text = nil
-- function interactWithNPC(ped)
--     while true do
--         Citizen.Wait(0)
--         local pedCoords = GetEntityCoords(ped)
--         local playerCoords = GetEntityCoords(PlayerPedId())
        
--         if #(playerCoords - pedCoords) < 2.0 then
--             DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, "Pressione E para conversar.")
            
--             if IsControlJustReleased(1, 51) then
--                 if Text == nil then
--                     Text = cfg.textosAleatorios[math.random(#cfg.textosAleatorios)]
--                 end
--                 -- Chama o evento do servidor
--                 --showDialog(Text)
--                 TriggerEvent("Notify","sucesso","NPC: "..Text,5)
--             end
--         else
--             Text = nil
--         end
--     end
-- end

function interactWithNPC(ped, missionIndex, text)
    while true do
        Citizen.Wait(0)
        local pedCoords = GetEntityCoords(ped)
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        if #(playerCoords - pedCoords) < 2.0 then
            DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, "Pressione E para interagir.")
            
            if IsControlJustReleased(1, 51) then
                -- Chame o evento do servidor aqui com informações sobre a missão e o texto específico
                TriggerServerEvent("InteractWithNPC", missionIndex, text)
            end
        end
    end
end



function CreateNPC(missionIndex)
    local model = GetHashKey(cfg.npc.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local missionData = cfg.Casos[missionIndex]

    local npcCount = 0

    for _, servicoData in pairs(missionData.servicos) do
        local x, y, z = servicoData[1], servicoData[2], servicoData[3]
        local ped = CreatePed(4, model, x, y, z, 0.0, false, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedDropsWeaponsWhenDead(ped, false)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

		print(servicoData[1], servicoData[2], servicoData[3])

        local randomText = cfg.textosAleatorios[math.random(#cfg.textosAleatorios)]
        table.insert(npcs, { ped = ped, text = randomText })

        npcCount = npcCount + 1

        if npcCount >= 6 then
            return
        end

		
    end
end










-----------------------------------------------------------------------------------------------------------------------------------------
-- Função para Inicializar do NPC
-----------------------------------------------------------------------------------------------------------------------------------------
-- function CreateNPC()
-- 	local model = GetHashKey(cfg.npc.model)
--     RequestModel(model)
--     while not HasModelLoaded(model) do
--         Wait(1)
--     end

--     local ped = CreatePed(4, model, cfg.npc.coords.x, cfg.npc.coords.y, cfg.npc.coords.z, 0.0, false, true)
-- 	local ped2 = CreatePed(4, model, cfg.npc.coords.x, cfg.npc.coords.y, cfg.npc.coords.z, 0.0, false, true)
-- 	local ped3 = CreatePed(4, model, cfg.npc.coords.x, cfg.npc.coords.y, cfg.npc.coords.z, 0.0, false, true)
-- 	local ped4 = CreatePed(4, model, cfg.npc.coords.x, cfg.npc.coords.y, cfg.npc.coords.z, 0.0, false, true)
-- 	local ped5 = CreatePed(4, model, cfg.npc.coords.x, cfg.npc.coords.y, cfg.npc.coords.z, 0.0, false, true)
-- 	local ped6 = CreatePed(4, model, cfg.npc.coords.x, cfg.npc.coords.y, cfg.npc.coords.z, 0.0, false, true)
--     SetPedFleeAttributes(ped, 0, 0)
--     SetPedDropsWeaponsWhenDead(ped, false)
--     SetEntityInvincible(ped, true)
--     SetBlockingOfNonTemporaryEvents(ped, true)
--     FreezeEntityPosition(ped, true)

-- 	table.insert(npcs, ped)
-- 	table.insert(npcs, ped2)
-- 	table.insert(npcs, ped3)
-- 	table.insert(npcs, ped4)
-- 	table.insert(npcs, ped5)
-- 	table.insert(npcs, ped6)

-- 	print(npcs[1])
-- 	print(npcs[2])
-- 	print(npcs[3])
-- 	print(npcs[4])
-- 	print(npcs[5])
-- 	print(npcs[6])
--     interactWithNPC(ped) -- Inicia a interação
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Função que deleta os npcs criados
-----------------------------------------------------------------------------------------------------------------------------------------
function DeleteAllNPCs()
    for _, ped in pairs(npcs) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    npcs = {} -- Limpa a tabela após deletar os NPCs
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- Função para mostrar o texto acima do NPC
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0140, 0.015 + factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Função para mostrar o texto no blip
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawTxtB(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

