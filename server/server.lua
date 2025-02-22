local QBCore = exports['qb-core']:GetCoreObject()

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Omega248/os-policegarage/main/version', function(err, newestVersion, headers)
        if err ~= 200 or not newestVersion or newestVersion == "" then
            print("Error checking version for " .. GetCurrentResourceName() .. ". Error code: " .. tostring(err))
            return
        end

        if newestVersion:gsub("%s+", "") ~= GetResourceMetadata(GetCurrentResourceName(), 'version'):gsub("%s+", "") then 
            print(string.format("^1Outdated version of %s detected.^7\nCurrent Version: %s, Latest Version: %s\nUpdate at: https://github.com/Omega248/os-policegarage/releases", 
                GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'version'), newestVersion))
        end
    end, 'GET')
end
CheckVersion()

RegisterNetEvent("policegarage:addTrunkItems")
AddEventHandler("policegarage:addTrunkItems", function(plate, trunkItems)
    local trunkInventory = 'trunk-' .. plate

    if not exports['qb-inventory']:GetInventory(trunkInventory) then
        exports['qb-inventory']:CreateInventory(trunkInventory)
        Citizen.Wait(100)
    end

    for slot, item in pairs(trunkItems) do
        exports['qb-inventory']:AddItem(trunkInventory, item.name, item.amount, slot, item.info)
    end

end)
