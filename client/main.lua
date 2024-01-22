local QBCore = exports['qb-core']:GetCoreObject()

local garageLoopActive = false
local PlayerData = {}
local myPeds = {}

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
    if PlayerData.job and PlayerData.job.name then
        if type(Config.PoliceJobs) == "table" then
            for _, policeJob in ipairs(Config.PoliceJobs) do
                if PlayerData.job.name == policeJob then
                    StartGarageLoop()
                    return
                end
            end
        elseif type(Config.PoliceJobs) == "string" then
            if PlayerData.job.name == Config.PoliceJobs then
                StartGarageLoop()
                return
            end
        end
    end
    StopGarageLoop()
end

function StartGarageLoop()
    if not garageLoopActive then
        garageLoopActive = true
        Citizen.CreateThread(function()
            while garageLoopActive do
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)

                for i, loc in ipairs(Config.PedLocations) do
                    local npcLocation = vector3(loc.coords.x, loc.coords.y, loc.coords.z)
                    local dist = #(npcLocation - pos)

                    if dist < 30 and not myPeds[i] then
                        myPeds[i] = CreateMyPed(loc.model, loc.coords, loc.coords.w)
                        if myPeds[i] then
                            SetEntityAlpha(myPeds[i], 0, false)
                            for alpha = 0, 255, 51 do
                                SetEntityAlpha(myPeds[i], alpha, false)
                                Citizen.Wait(50)
                            end
                        end
                    elseif dist >= 30 and myPeds[i] then
                        for alpha = 255, 0, -51 do
                            SetEntityAlpha(myPeds[i], alpha, false)
                            Citizen.Wait(50)
                        end
                        DeleteEntity(myPeds[i])
                        myPeds[i] = nil
                    end
                end
                Citizen.Wait(1500)
            end
        end)
    end
end

function StopGarageLoop()
    if garageLoopActive then
        for i, ped in pairs(myPeds) do
            if DoesEntityExist(ped) then
                DeleteEntity(ped)
            end
        end
        myPeds = {}
        garageLoopActive = false
    end
end

function CreateMyPed(model, coords, heading)
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
    local ped = CreatePed(4, modelHash, coords.x, coords.y, coords.z, heading, false, true)
    if not ped then
        print("Failed to create ped.")
    else
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

    if Config.RestrictVehiclesRank and data.vehicle.rank then
        local Rank = QBCore.Functions.GetPlayerData().job.grade.level
        if data.vehicle.rank > Rank then
            QBCore.Functions.Notify("This vehicle is for a higher rank than you", "error")
            return
        end
    end

    if Config.RestrictVehiclesJob and data.vehicle.job then
        if data.vehicle.job ~= PlayerData.job.name then
            QBCore.Functions.Notify("This vehicle is for a different department", "error")
            return
        end
    end

    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local closestPdLocation = nil
    local minDistance = math.huge

    for _, pedLocation in ipairs(Config.PedLocations) do
        local distance = #(pedCoords - vector3(pedLocation.coords.x, pedLocation.coords.y, pedLocation.coords.z))
        if distance < minDistance then
            minDistance = distance
            closestPdLocation = pedLocation.pd
        end
    end

    if closestPdLocation then
        local clearSpotFound, spawnPoint = false, nil
        for _, vehLocation in ipairs(Config.VehSpawnLocations) do
            if vehLocation.pd == closestPdLocation then
                if not IsAnyVehicleNearPoint(vehLocation.coords.x, vehLocation.coords.y, vehLocation.coords.z, 2.5) then
                    clearSpotFound, spawnPoint = true, vehLocation
                    break
                end
            end
        end

        if not clearSpotFound then
            QBCore.Functions.Notify("All spawn areas for " .. closestPdLocation .. " are full", "error")
            return
        end

        QBCore.Functions.SpawnVehicle(data.vehicle.model, function(veh)
            if not veh or not DoesEntityExist(veh) then
                QBCore.Functions.Notify("Failed to spawn vehicle!", "error")
                return
            end
            SetVehicleModKit(veh, 0)
            if Config.Maxmods then
                local performanceModIndices = { 11, 12, 13, 15 }
                for _, modType in ipairs(performanceModIndices) do
                    local maxModIndex = GetNumVehicleMods(veh, modType) - 1
                    SetVehicleMod(veh, modType, maxModIndex, false)
                end
                if Config.Turbo then
                    ToggleVehicleMod(veh, 18, true)
                else
                end
            end
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
        end, spawnPoint.coords, true)
    else
        QBCore.Functions.Notify("No PD locations are available.", "error")
    end
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
