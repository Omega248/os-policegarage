local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local spawnped = false


RegisterNetEvent('QBCore:client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function (Player)
    PlayerData = QBCore.Functions.GetPlayerData()    
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:client:OnJobUpdate', function (job)
    PlayerJob = job
end)

exports['qb-target']:AddBoxZone("PoliceGarage", vector3(459.6, -986.6, 24.7), 0.65, 0.75, {
	name = "PoliceGarage",
	heading = 273.52,
	debugPoly = false,
	minZ = 24.57834,
	maxZ = 26.57834,
}, {
	options = {
		{
            type = "client",
            event = "garage:policemenu",
			icon = "fa-solid fa-warehouse",
			label = "Police Garage",
			job = "police",
		},
	},
	distance = 2.5
})

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k, v in pairs(Config.Pedlocation) do
            local pos = GetEntityCoords(PlayerPedId())
            local dist = #(v.Cords - pos)
            if dist < 40 and spawnped == false then
                TriggerEvent('spawn:npc',v.Cords,v.h)
                spawnped = true
            end
            if dist >= 35 then 
                spawnped = false
                DeletePed(npc)
            end
        end
    end
end)

RegisterNetEvent('spawn:npc')
AddEventHandler('spawn:npc', function(coords,heading)
    local hash = GetHashKey(Config.NPCmodel)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(150)
    end
    while not HasModelLoaded(hash) do
        Wait(150)
    end
    spawnped = true
    npc = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityInvincible(npc, true)
    loadAnimDict("amb@world_human_drug_dealer_hard@male@base")
    while not TaskPlayAnim(npc, "amb@world_human_drug_dealer_hard@male@base", "base", 8.0, 1.0, -1, 17, 0, 0, 0) do
    Wait(1000)
    end  
end)

function loadAnimDict(dict)
    while ( not HasAnimDictLoaded(dict)) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

RegisterNetEvent('policegarage:lspd')
AddEventHandler('policegarage:lspd', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 451.08, ['y'] = -975.77, ['z'] = 25.5, ['h'] = 90.07 } --Change this to wherever you want to car to spawn
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        if vehicle == "cvpi(ChangeMe)" then --change this to your cvpi spawn code
            SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 1, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 0, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 111, 0)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen an LSPD CVPI")
        elseif vehicle == "Explorer(ChangeMe)" then --change this to your explorer spawn code
            SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 0, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 0, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 111, 0)
            SetVehicleDashboardColour(veh, 0)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen an LSPD Explorer")
        elseif vehicle == "Charger(ChangeMe)" then --change this to your charger spawn code
            SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 1, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 0, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 111, 0)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen an LSPD Charger")
        end
    end, coords, true)
end)

RegisterNetEvent('policegarage:bcso')
AddEventHandler('policegarage:bcso', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 451.08, ['y'] = -975.77, ['z'] = 25.5, ['h'] = 90.07 } --Change this to wherever you want to car to spawn
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        if vehicle == "cvpi(ChangeMe)" then --change this to your cvpi spawn code
            SetVehicleNumberPlateText(veh, "BCSO"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 1, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 2, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 111, 49)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen a Blaine County CVPI")
        elseif vehicle == "Explorer(ChangeMe)" then --change this to your explorer spawn code
            SetVehicleNumberPlateText(veh, "BCSO"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 0, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 2, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 111, 49)
            SetVehicleDashboardColour(veh, 0)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen a Blaine County Explorer")
        elseif vehicle == "Charger(ChangeMe)" then --change this to your charger spawn code
            SetVehicleNumberPlateText(veh, "BCSO"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 1, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 1, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 111, 49)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen a Blaine County Charger")
        end
    end, coords, true)
end)

RegisterNetEvent('policegarage:sast')
AddEventHandler('policegarage:sast', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 451.08, ['y'] = -975.77, ['z'] = 25.5, ['h'] = 90.07 } 
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        if vehicle == "cvpi(ChangeMe)" then --change this to your cvpi spawn code
            SetVehicleNumberPlateText(veh, "SAST"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 2, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 4, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 62, 62)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen a State CVPI")
        elseif vehicle == "Explorer(ChangeMe)" then --change this to your explorer spawn code
            SetVehicleNumberPlateText(veh, "SAST"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 0, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 4, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 62, 62)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen a State Explorer")
        elseif vehicle == "Charger(ChangeMe)" then --change this to your charger spawn code
            SetVehicleNumberPlateText(veh, "SAST"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0)
            SetVehicleExtra(veh, 8, 0)
            SetVehicleMod(veh, 1, 1, 1)
            SetVehicleMod(veh, 8, 0, 1)
            SetVehicleMod(veh, 9, 2, 1)
            SetVehicleMod(veh, 48, 2, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 62, 62)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen a State charger")
        else
            SetVehicleNumberPlateText(veh, "INT"..tostring(math.random(1000, 9999)))
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetEntityHeading(veh, coords.h)
            SetVehicleModKit(veh, 0)
            SetVehicleExtra(veh, 1, 0)  
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 0)
            SetVehicleExtra(veh, 6, 0)
            SetVehicleExtra(veh, 7, 0) 
            SetVehicleExtra(veh, 8, 0) 
            SetVehicleMod(veh, 1, 1, 1)
            SetVehicleMod(veh, 8, 7, 1)
            SetVehicleMod(veh, 6, 0, 1)
            SetVehicleMod(veh, 9, 3, 1)
            SetVehicleMod(veh, 48, 3, 1)
            SetVehicleMod(veh, 32, 0, 1)
            SetVehicleMod(veh, 37, 2, 1)
            SetVehicleMod(veh, 17, 0, 1)
            SetVehicleColours(veh, 0, 0)
            SetVehicleDashboardColour(veh, 111)
            SetVehicleWindowTint(veh, 3)
            SetVehicleDirtLevel(veh, 0.0)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("You have chosen an interceptor")
        end
    end, coords, true)
end)

RegisterNetEvent('policegarage:storecar')
AddEventHandler('policegarage:storecar', function()
local car = GetVehiclePedIsIn(PlayerPedId(),true)
DeleteVehicle(car)
DeleteEntity(car)
if car == 0 then 
    QBCore.Functions.Notify("You don't have a vehicle nearby")
    else 
        QBCore.Functions.Notify("You're Vehicle Has Been Stored")
    end
end)

RegisterNetEvent('qb-menu:client:lspd', function(data)
    local number = data.number
    exports['qb-menu']:openMenu({
        {
            header = "< Go Back",
            params = {
                event =  "garage:policemenu"
            }
        },
        {
            header = "CVPI",
            txt = "Police CVPI",
            params = {
                event = "policegarage:lspd",
                args = {
                    vehicle = 'cvpi(ChangeMe)', --change this to your cvpi spawn code
                    
                }
            }
        },
        {
            header = "Explorer",
            txt = "Police Explorer",
            params = {
                event = "policegarage:lspd",
                args = {
                    vehicle = 'Explorer(ChangeMe)', --change this to your explorer spawn code
                    
                }
            }
        },
        {
        header = "Charger",
        txt = "Police Charger",
        params = {
            event = "policegarage:lspd",
            args = {
                vehicle = 'Charger(ChangeMe)', --change this to your charger spawn code
                
            }
        }
    },
    })
end)

RegisterNetEvent('qb-menu:client:bcso', function(data)
    local number = data.number
    exports['qb-menu']:openMenu({
        {
            header = "< Go Back",
            params = {
                event =  "garage:policemenu"
            }
        },
        {
            header = "CVPI",
            txt = "Police CVPI",
            params = {
                event = "policegarage:bcso",
                args = {
                    vehicle = 'cvpi(ChangeMe)', --change this to your cvpi spawn code
                    
                }
            }
        },
        {
            header = "Explorer",
            txt = "Police Explorer",
            params = {
                event = "policegarage:bcso",
                args = {
                    vehicle = 'Explorer(ChangeMe)', --change this to your explorer spawn code
                    
                }
            }
        },
        {
        header = "Charger",
        txt = "Police Charger",
        params = {
            event = "policegarage:bcso",
            args = {
                vehicle = 'Charger(ChangeMe)', --change this to your charger spawn code
                
            }
        }
    },
    })
end)

RegisterNetEvent('qb-menu:client:sast', function(data)
    local number = data.number
    exports['qb-menu']:openMenu({
        {
            header = "< Go Back",
            params = {
                event =  "garage:policemenu"
            }
        },
        {
            header = "CVPI",
            txt = "Police CVPI",
            params = {
                event = "policegarage:sast",
                args = {
                    vehicle = 'cvpi(ChangeMe)', --change this to your cvpi spawn code
                    
                }
            }
        },
        {
            header = "Explorer",
            txt = "Police Explorer",
            params = {
                event = "policegarage:sast",
                args = {
                    vehicle = 'Explorer(ChangeMe)', --change this to your explorer spawn code
                    
                }
            }
        },
        {
        header = "Charger",
        txt = "Police Charger",
        params = {
            event = "policegarage:sast",
            args = {
                vehicle = 'Charger(ChangeMe)', --change this to your charger spawn code
                
            }
        }
    },
    })
end)

RegisterNetEvent('qb-menu:client:interceptor', function(data)
    local number = data.number
    exports['qb-menu']:openMenu({
        {
            header = "< Go Back",
            params = {
                event =  "garage:policemenu"
            }
        },
        {
            header = "Challanger(ChangeMe)langer",
            txt = "Police Challanger(ChangeMe)langer",
            params = {
                event = "policegarage:sast",
                args = {
                    vehicle = 'Challanger(ChangeMe)',
                    
                }
            }
        },
        {
            header = "Mustang",
            txt = "Police Mustang",
            params = {
                event = "policegarage:sast",
                args = {
                    vehicle = 'Mustang(ChangeMe)',
                    
                }
            }
        },
        {
            header = "Corvette",
            txt = "Police Corvette",
            params = {
                event = "policegarage:sast",
                args = {
                    vehicle = 'corvette(ChangeMe)',
                    
                }
            }
        },
    })
end)

RegisterNetEvent('garage:policemenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Police Garage",
            txt = ""
        },
        {
            header = "LSPD",
            txt = "LSPD Cruisers",
            params = {
                event = "qb-menu:client:lspd",
                args = {
                    number = 1,2,
                    
                }
            }
        },
        {
            header = "BCSO",
            txt = "BCSO Cruisers",
            params = {
                event = "qb-menu:client:bcso",
                args = {
                    number = 1,2,
                    
                }
            }
        },
        {
            header = "SAST",
            txt = "SAST Cruisers",
            params = {
                event = "qb-menu:client:sast",
                args = {
                    number = 1,2,
                    
                }
            }
        },
        {
            header = "Interceptors",
            txt = "For Trained Officers Only",
            params = {
                event = "qb-menu:client:interceptor",
                args = {
                    number = 1,2,
                    
                }
            }
        },
        {
            header = "Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "policegarage:storecar",
                args = {
                    
                }
            }
        },
        {
            header = "Close (esc)",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
                args = {
                    
                }
            }
        },
        
    })
end)
