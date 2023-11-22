cfg = {}




cfg.useNui = false
cfg.useBlip = true


cfg.locWork = { -- Localizações das arenas
    vec3(119.69,-344.55,42.97)
}

cfg.botaoTrabalho = 47 -- [G]

cfg.drawTxt = function()
    DrawTxtB("PRESSIONE ~b~[G] ~w~PARA ~b~INICIAR ~w~O SERVIÇO DE INVESTIGAÇÃO",4,0.5,0.93,0.50,255,255,255,180)
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

cfg.level = {
    ganhoXp = 2,
    dinheiroAumenta = 1000,
    XpNescessarioAumenta = 350,
}

cfg.Casos = {
    [1] = {
        -- ['entrada'] = {-1540.02,420.74,110.02},
        ['servicos'] = {
            [1] = {-1509.5,400.76,107.49, 'faca', "amb@world_human_janitor@male@idle_a", "idle_a", "prop_tool_broom", 49, 28422 },
            [2] = {-1549.88,395.4,108.43, 'pa', "amb@world_human_bum_wash@male@high@base", "base"},
            [3] = {-1529.53,424.58,109.76, 'arma', "amb@code_human_wander_gardener_leaf_blower@idle_a", "idle_b", "prop_leaf_blower_01", 49, 28422},
            [4] = {-1541.93,433.4,109.2, 'sangue', "amb@code_human_wander_gardener_leaf_blower@idle_a", "idle_b", "prop_leaf_blower_01", 49, 28422}
        }
    },
    [2] = {
        -- ['entrada'] = {1060.54,-378.09,68.24},
        ['servicos'] = {
            [1] = {1047.95,-372.4,67.85, 'Soldar', "WORLD_HUMAN_WELDING" },
            [2] = {1044.33,-372.88,67.9, 'Plantar semente', "amb@world_human_gardener_plant@female@base", "base_female"},
            [3] = {1065.64,-377.23,67.92, 'Soprar folhas', "amb@code_human_wander_gardener_leaf_blower@idle_a", "idle_b", "prop_leaf_blower_01", 49, 28422},
            [4] = {1049.79,-369.9,68.24, 'Consertar maçaneta', "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
        }
    },

    [3] = {
        -- ['entrada'] = {1060.54,-378.09,68.24},
        ['servicos'] = {
            [1] = {2040.13,-372.4,67.85, 'Soldar', "WORLD_HUMAN_WELDING" },
            [2] = {1044.33,-372.88,67.9, 'Plantar semente', "amb@world_human_gardener_plant@female@base", "base_female"},
            [3] = {1065.64,-377.23,67.92, 'Soprar folhas', "amb@code_human_wander_gardener_leaf_blower@idle_a", "idle_b", "prop_leaf_blower_01", 49, 28422},
            [4] = {1049.79,-369.9,68.24, 'Consertar maçaneta', "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
        }
    },

    [4] = {
        -- ['entrada'] = {1060.54,-378.09,68.24},
        ['servicos'] = {
            [1] = {47.95,-372.4,67.85, 'Soldar', "WORLD_HUMAN_WELDING" },
            [2] = {1044.33,-372.88,67.9, 'Plantar semente', "amb@world_human_gardener_plant@female@base", "base_female"},
            [3] = {1065.64,-377.23,67.92, 'Soprar folhas', "amb@code_human_wander_gardener_leaf_blower@idle_a", "idle_b", "prop_leaf_blower_01", 49, 28422},
            [4] = {1049.79,-369.9,68.24, 'Consertar maçaneta', "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
        }
    },

    [5] = {
        -- ['entrada'] = {1060.54,-378.09,68.24},
        ['servicos'] = {
            [1] = {470.95,-372.4,67.85, 'Soldar', "WORLD_HUMAN_WELDING" },
            [2] = {1044.33,-372.88,67.9, 'Plantar semente', "amb@world_human_gardener_plant@female@base", "base_female"},
            [3] = {1065.64,-377.23,67.92, 'Soprar folhas', "amb@code_human_wander_gardener_leaf_blower@idle_a", "idle_b", "prop_leaf_blower_01", 49, 28422},
            [4] = {1049.79,-369.9,68.24, 'Consertar maçaneta', "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
        }
    },
}




--[[cfg.locais = {

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

}--]]

return cfg
