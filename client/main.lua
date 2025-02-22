local QBCore = exports['qb-core']:GetCoreObject()

local garageLoopActive = false
local PlayerData = {}
local myPeds = {}

local function UpdatePlayerData()
    PlayerData = QBCore.Functions.GetPlayerData()
    CheckAndStartGarageLoop()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', UpdatePlayerData)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    CheckAndStartGarageLoop()
end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    StopGarageLoop()
end)

Citizen.CreateThread(function()
    while not QBCore or not QBCore.Functions.GetPlayerData().job do
        Citizen.Wait(1000)
    end
    UpdatePlayerData()
end)

local function IsPoliceJob(jobName)
    if type(Config.PoliceJobs) == "table" then
        for _, policeJob in ipairs(Config.PoliceJobs) do
            if jobName == policeJob then return true end
        end
    elseif type(Config.PoliceJobs) == "string" then
        return jobName == Config.PoliceJobs
    end
    return false
end

function CheckAndStartGarageLoop()
    local jobName = PlayerData.job and PlayerData.job.name
    if jobName and IsPoliceJob(jobName) then
        StartGarageLoop()
    else
        StopGarageLoop()
    end
end

local function fadeEntityAlpha(entity, startAlpha, endAlpha, step, delay)
    for alpha = startAlpha, endAlpha, step do
        SetEntityAlpha(entity, alpha, false)
        Citizen.Wait(delay)
    end
end

function StartGarageLoop()
    if garageLoopActive then return end
    garageLoopActive = true

    Citizen.CreateThread(function()
        while garageLoopActive do
            local playerPed = PlayerPedId()
            local pos = GetEntityCoords(playerPed)

            for i, loc in ipairs(Config.PedLocations) do
                local npcLocation = loc.coords.xyz
                local dist = #(pos - npcLocation)

                if dist < 30 and not myPeds[i] then
                    myPeds[i] = CreateMyPed(loc.model, loc.coords, loc.coords.w)
                    if myPeds[i] then
                        fadeEntityAlpha(myPeds[i], 0, 255, 51, 50)
                    end
                elseif dist >= 30 and myPeds[i] then
                    fadeEntityAlpha(myPeds[i], 255, 0, -51, 50)
                    DeleteEntity(myPeds[i])
                    myPeds[i] = nil
                end
            end

            Citizen.Wait(1500)
        end
    end)
end

function StopGarageLoop()
    if not garageLoopActive then return end
    for _, ped in pairs(myPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    myPeds = {}
    garageLoopActive = false
end

function CreateMyPed(model, coords, heading)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    local maxAttempts = 20
    for attempts = 1, maxAttempts do
        if HasModelLoaded(modelHash) then break end
        Citizen.Wait(10)
        if attempts == maxAttempts then
            print("Failed to load model: " .. model)
            return nil
        end
    end

    local ped = CreatePed(4, modelHash, coords.x, coords.y, coords.z, heading, false, true)
    if not ped then
        print("Failed to create ped for model: " .. model)
        return nil
    end

    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityAlpha(ped, 0, false)

    return ped
end

RegisterNetEvent('policegarage:spawnVehicle')
AddEventHandler('policegarage:spawnVehicle', function(data)
    if not data or not data.vehicle then
        return QBCore.Functions.Notify("Vehicle data is missing!", "error")
    end

    local playerData = QBCore.Functions.GetPlayerData()

    if Config.RestrictVehiclesRank and data.vehicle.rank and data.vehicle.rank > playerData.job.grade.level then
        return QBCore.Functions.Notify("This vehicle is for a higher rank than you", "error")
    end

    if Config.RestrictVehiclesJob and data.vehicle.job and data.vehicle.job ~= playerData.job.name then
        return QBCore.Functions.Notify("This vehicle is for a different department", "error")
    end

    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local closestPdLocation, minDistance = nil, math.huge

    for _, pedLocation in ipairs(Config.PedLocations) do
        local distance = #(pedCoords - vector3(pedLocation.coords.x, pedLocation.coords.y, pedLocation.coords.z))
        if distance < minDistance then
            minDistance = distance
            closestPdLocation = pedLocation.pd
        end
    end

    if not closestPdLocation then
        return QBCore.Functions.Notify("No PD locations are available.", "error")
    end

    local spawnPoint = nil
    for _, vehLocation in ipairs(Config.VehSpawnLocations) do
        if vehLocation.pd == closestPdLocation and not IsAnyVehicleNearPoint(vehLocation.coords.x, vehLocation.coords.y, vehLocation.coords.z, 2.5) then
            spawnPoint = vehLocation
            break
        end
    end

    if not spawnPoint then
        return QBCore.Functions.Notify("All spawn areas for " .. closestPdLocation .. " are full", "error")
    end

    QBCore.Functions.SpawnVehicle(data.vehicle.model, function(veh)
        if not veh or not DoesEntityExist(veh) then
            return QBCore.Functions.Notify("Failed to spawn vehicle!", "error")
        end

        SetVehicleModKit(veh, 0)
        if Config.Maxmods then
            for _, modType in ipairs({ 11, 12, 13, 15 }) do
                SetVehicleMod(veh, modType, GetNumVehicleMods(veh, modType) - 1, false)
            end
            if Config.Turbo then
                ToggleVehicleMod(veh, 18, true)
            end
        end

        for _, mod in ipairs(data.vehicle.mods or {}) do
            SetVehicleMod(veh, mod.id, mod.modenabled, false)
        end

        for _, extra in ipairs(data.vehicle.extras or {}) do
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
        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))

        if data.vehicle.trunkItems then
            TriggerServerEvent("policegarage:addTrunkItems", plateText, data.vehicle.trunkItems)
        end

        SetVehicleEngineOn(veh, true, true, false)
    end, spawnPoint.coords, true)
end)

RegisterNetEvent('policegarage:storecar')
AddEventHandler('policegarage:storecar', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    if not vehicle or vehicle == 0 then
        return QBCore.Functions.Notify("You don't have a vehicle nearby")
    end

    if GetVehicleClass(vehicle) == 18 then
        DeleteVehicle(vehicle)
        QBCore.Functions.Notify("Your Vehicle Has Been Stored")
    else
        QBCore.Functions.Notify("This is not a police vehicle")
    end
end)
