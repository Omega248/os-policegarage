local QBCore = exports['qb-core']:GetCoreObject()

local function addTargetZone(name, coords, heading)
    local policeJobsOptions = {}

    if type(Config.PoliceJobs) == "table" then
        for _, jobName in ipairs(Config.PoliceJobs) do
            table.insert(policeJobsOptions, {
                type = "client",
                event = "garage:policemenu",
                icon = "fa-solid fa-warehouse",
                label = "Police Garage",
                job = jobName
            })
        end
    elseif type(Config.PoliceJobs) == "string" then
        policeJobsOptions = {
            {
                type = "client",
                event = "garage:policemenu",
                icon = "fa-solid fa-warehouse",
                label = "Police Garage",
                job = Config.PoliceJobs
            }
        }
    end

    exports['qb-target']:AddBoxZone(name, coords, 0.65, 0.75, {
        name = name,
        heading = heading,
        debugPoly = false,
        minZ = coords.z,
        maxZ = coords.z + 1.85,
    }, {
        options = policeJobsOptions,
        distance = 2.5
    })
end

if Config and Config.PedLocations then
    for i, loc in ipairs(Config.PedLocations) do
        local zoneName = "PoliceGarage_" .. i
        local zoneCoords = vector3(loc.coords.x, loc.coords.y, loc.coords.z)
        local zoneHeading = loc.coords.w
        addTargetZone(zoneName, zoneCoords, zoneHeading)
    end
else
    print("Config.PedLocations is not defined or is nil.")
end
