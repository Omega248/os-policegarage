local QBCore = exports['qb-core']:GetCoreObject()

function CreateDepartmentMenu(departmentName, departmentVehicles)
    local menuItems = {
        {
            header = '< Go Back',
            params = {
                event = "garage:policemenu"
            }
        }
    }

    for vehicleName, vehicleData in pairs(departmentVehicles) do
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

    return menuItems
end

RegisterNetEvent('garage:policemenu', function()
    local mainMenuItems = {
        {
            header = 'Police Garage',
            params = {
                event = "garage:policemenu"
            }
        }
    }

    local departmentNames = {}
    for departmentName in pairs(Config.DepartmentVehicles) do
        table.insert(departmentNames, departmentName)
    end

    table.sort(departmentNames)

    for _, departmentName in ipairs(departmentNames) do
        local departmentVehicles = Config.DepartmentVehicles[departmentName]
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

    table.insert(mainMenuItems, {
        header = 'Store Vehicle',
        params = {
            event = "policegarage:storecar",
            args = {}
        }
    })

    table.insert(mainMenuItems, {
        header = 'X Close',
        params = {
            event = "qb-menu:closeMenu",
            args = {}
        }
    })

    exports['qb-menu']:openMenu(mainMenuItems)
end)

RegisterNetEvent('qb-menu:client:openDepartmentMenu', function(data)
    if data and data.departmentName and data.departmentVehicles then
        exports['qb-menu']:openMenu(CreateDepartmentMenu(data.departmentName, data.departmentVehicles))
    end
end)
