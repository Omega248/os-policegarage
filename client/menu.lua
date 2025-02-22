local QBCore = exports['qb-core']:GetCoreObject()

function CreateDepartmentMenu(departmentName, departmentVehicles)
    local menuItems = {
        {
            header = '< Go Back',
            params = { event = "garage:policemenu" }
        }
    }

    local playerData = QBCore.Functions.GetPlayerData()
    local playerJob = (playerData and playerData.job and playerData.job.name) or nil
    local playerRank = (playerData and playerData.job and (playerData.job.grade.level or playerData.job.grade)) or 0
    print("DEBUG: Player Job:", playerJob, "Player Rank:", playerRank)

    for vehicleName, vehicleData in pairs(departmentVehicles) do
        local canDrive = true

        if Config.RestrictVehiclesRank and vehicleData.rank and playerRank < vehicleData.rank then
            canDrive = false
        end

        if Config.RestrictVehiclesJob and vehicleData.job and playerJob and vehicleData.job ~= playerJob then
            canDrive = false
        end

        if canDrive then
            table.insert(menuItems, {
                header = vehicleData.label,
                params = {
                    event = "policegarage:spawnVehicle",
                    args = {
                        Department = departmentName,
                        vehicle = vehicleData,
                    }
                }
            })
        end
    end

    return menuItems
end
RegisterNetEvent('garage:policemenu', function()
    local mainMenuItems = {
        {
            header = 'Police Garage',
            params = { event = "garage:policemenu" }
        }
    }

    local departmentNames = {}
    for departmentName in pairs(Config.DepartmentVehicles) do
        table.insert(departmentNames, departmentName)
    end
    table.sort(departmentNames)

    for _, departmentName in ipairs(departmentNames) do
        local departmentVehicles = Config.DepartmentVehicles[departmentName]
        local departmentMenu = CreateDepartmentMenu(departmentName, departmentVehicles)
        if #departmentMenu > 1 then 
            table.insert(mainMenuItems, {
                header = departmentName,
                params = {
                    event = "qb-menu:client:openDepartmentMenu",
                    args = {
                        departmentName = departmentName,
                        departmentVehicles = departmentVehicles
                    }
                }
            })
        end
    end

    table.insert(mainMenuItems, {
        header = 'Store Vehicle',
        params = { event = "policegarage:storecar", args = {} }
    })

    table.insert(mainMenuItems, {
        header = 'X Close',
        params = { event = "qb-menu:closeMenu", args = {} }
    })

    exports['qb-menu']:openMenu(mainMenuItems)
end)

RegisterNetEvent('qb-menu:client:openDepartmentMenu', function(data)
    if data and data.departmentName and data.departmentVehicles then
        exports['qb-menu']:openMenu(CreateDepartmentMenu(data.departmentName, data.departmentVehicles))
    end
end)
