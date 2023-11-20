cfg = {}




cfg.useNui = true
cfg.useBlip = false


cfg.locWork = { -- Localizações das arenas
    vec3(119.69,-344.55,42.97)
}

cfg.drawTxt = function()
    DrawTxtB("PRESSIONE  ~r~E~w~  PARA INICIAR O TRABALHO DE INVESTIGAÇÃO",4,0.5,0.93,0.50,255,255,255,180)
end

cfg.drawMarker = function(coords) -- DRAWMARKER DO BLIP 
    DrawMarker(21,coords,0,0,0,0,0,130.0, 0.5,0.5,0.5, 12,198,254,180 ,1,0,0,1)
end

cfg.npc = {
    hash = 0x787FA588,
    model = 'a_f_m_beach_01',
    coords = { x = 119.85, y = -346.24, z = 42.9 }, -- 119.85,-346.24,42.97
}

cfg.textosAleatorios = {
    "Parece que teve algum caso aqui...",
    "Acho melhor investigarem esta area...",
    "Pelo o que falaram alguem está sumido...",
    -- Adicione mais textos aqui
}

--[[


cfg.trabalho = 
cfg.ganhoXp =
cfg.xpUpar = 
cfg.dinheiro = 




cfg.locais = {

    [1] = {
        ["nome"] =
        ["coord"] =
        ["hash"] =
        ["ped"] =
        ["coord-ped"] = 
    },

    [2] = {
        ["nome"] =
        ["coord"] =
        ["hash"] =
        ["ped"] =
        ["coord-ped"] = 
    },

    [3] = {
        ["nome"] =
        ["coord"] =
        ["hash"] =
        ["ped"] =
        ["coord-ped"] = 
    }

}-]]

return cfg