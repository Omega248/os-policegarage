local QBCore = exports['qb-core']:GetCoreObject()

local garageLoopActive = false
local PlayerData = {}
local myPed = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    CheckAndStartGarageLoop()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    StopGarageLoop()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    CheckAndStartGarageLoop()
end)

Citizen.CreateThread(function()
    while QBCore == nil or QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(1000)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
    CheckAndStartGarageLoop()
end)

function CheckAndStartGarageLoop()
    if PlayerData.job and PlayerData.job.name == "police" then
        StartGarageLoop()
    else
        StopGarageLoop()
    end
end

function StartGarageLoop()
    if not garageLoopActive then
        garageLoopActive = true
        Citizen.CreateThread(function()
            while garageLoopActive do
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)
                local dist = #(Config.NPClocation - pos)

                if dist < 30 and not myPed then
                    myPed = CreateMyPed()
                    if myPed then
                        for alpha = 0, 255, 51 do
                            SetEntityAlpha(myPed, alpha, false)
                            Citizen.Wait(50)
                        end
                    end
                elseif dist >= 30 and myPed then
                    for alpha = 255, 0, -51 do
                        SetEntityAlpha(myPed, alpha, false)
                        Citizen.Wait(50)
                    end
                    DeleteEntity(myPed)
                    myPed = nil
                end
                Citizen.Wait(2500)
            end
        end)
    end
end

function StopGarageLoop()
    if garageLoopActive and myPed then
        DeleteEntity(myPed)
        myPed = nil
    end
    garageLoopActive = false
end

function CreateMyPed()
    local model = Config.NPCmodel
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    local attempts = 0
    local maxAttempts = 20
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(10)
        attempts = attempts + 1
        if attempts >= maxAttempts then
            print("Failed to load model.")
            return nil
        end
    end
    local ped = CreatePed(4, modelHash, Config.NPClocation, false, true)
    if ped then
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityAlpha(ped, 0, false)
    end
    return ped
end

RegisterNetEvent('policegarage:spawnVehicle')
AddEventHandler('policegarage:spawnVehicle', function(data)
    if not data or not data.vehicle then
        QBCore.Functions.Notify("Vehicle data is missing!", "error")
        return
    end

    if Config.RestrictVehicles then
        local Rank = QBCore.Functions.GetPlayerData().job.grade.level
        if data.vehicle.rank > Rank then 
            QBCore.Functions.Notify("This vehicle is for a higher rank than you", "error")
            return
        end
    end

    local clearSpotFound, spawnPoint = false, nil
    for _, location in ipairs(Config.VehSpawnLocations) do
        if not IsAnyVehicleNearPoint(location.x, location.y, location.z, 2.5) then
            clearSpotFound, spawnPoint = true, location
            break
        end
    end

    if not clearSpotFound then
        QBCore.Functions.Notify("All spawn areas are full", "error")
        return
    end

    QBCore.Functions.SpawnVehicle(data.vehicle.model, function(veh)
        if not veh or not DoesEntityExist(veh) then
            QBCore.Functions.Notify("Failed to spawn vehicle!", "error")
            return
        end

        SetVehicleModKit(veh, 0)
        for _, mod in ipairs(data.vehicle.mods) do
            SetVehicleMod(veh, mod.id, mod.modenabled, false)
        end
        for _, extra in ipairs(data.vehicle.extras) do
            SetVehicleExtra(veh, extra.id, extra.enabled)
        end

        SetVehicleLivery(veh, data.vehicle.livery)
        local plateText = data.Department:upper() .. tostring(math.random(1000, 9999))
        SetVehicleNumberPlateText(veh, plateText)
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleColours(veh, data.vehicle.primarycolor, data.vehicle.secondarycolor)
        SetVehicleDashboardColour(veh, 111)
        SetVehicleExtraColours(veh, 0, 0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true, false)
    end, spawnPoint, true)
end)


RegisterNetEvent('policegarage:storecar')
AddEventHandler('policegarage:storecar', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, true)

    if vehicle and vehicle ~= 0 then
        local vehicleClass = GetVehicleClass(vehicle)
        if vehicleClass == 18 then
            DeleteVehicle(vehicle)
            QBCore.Functions.Notify("Your Vehicle Has Been Stored")
        else
            QBCore.Functions.Notify("This is not a police vehicle")
        end
    else
        QBCore.Functions.Notify("You don't have a vehicle nearby")
    end
end)
