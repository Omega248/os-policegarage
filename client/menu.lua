local QBCore = exports['qb-core']:GetCoreObject()

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

RegisterNetEvent('qb-menu:client:lspd', function(data)
    exports['qb-menu']:openMenu({
        {
            header = '< Go Back',
            params = {
                event = "garage:policemenu"
            }
        },
        {
            header = 'LSPD CVPI',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "LSPD",
                    vehicle = Config.DepartmentVehicles.LSPD.CVPI,
                }
            }
        },
        {
            header = 'LSPD Explorer',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "LSPD",
                    vehicle = Config.DepartmentVehicles.LSPD.Explorer,
                }
            }
        },
        {
            header = 'LSPD Charger',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "LSPD",
                    vehicle = Config.DepartmentVehicles.LSPD.Charger,
                }
            }
        },
    })
end)

RegisterNetEvent('qb-menu:client:bcso', function(data)
    exports['qb-menu']:openMenu({
        {
            header = '< Go Back',
            params = {
                event =  "garage:policemenu"
            }
        },
        {
            header = 'BCSO CVPI',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "BCSO",
                    vehicle = Config.DepartmentVehicles.BCSO.CVPI,
                }
            }
        },
        {
            header = 'BCSO Explorer',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "BCSO",
                    vehicle = Config.DepartmentVehicles.BCSO.Explorer,
                }
            }
        },
        {
            header = 'BCSO Charger',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "BCSO",
                    vehicle = Config.DepartmentVehicles.BCSO.Charger,
                }
            }
        },
    })
end)

RegisterNetEvent('qb-menu:client:sast', function(data)
    exports['qb-menu']:openMenu({
        {
            header = '< Go Back',
            params = {
                event =  "garage:policemenu"
            }
        },
        {
            header = 'SAST CVPI',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "SAST",
                    vehicle = Config.DepartmentVehicles.SAST.CVPI,
                }
            }
        },
        {
            header = 'SAST Explorer',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "SAST",
                    vehicle = Config.DepartmentVehicles.SAST.Explorer,
                }
            }
        },
        {
            header = 'SAST Charger',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "SAST",
                    vehicle = Config.DepartmentVehicles.SAST.Charger,
                }
            }
        },
    })
end)

RegisterNetEvent('qb-menu:client:interceptor', function(data)
    exports['qb-menu']:openMenu({
        {
            header = '< Go Back',
            params = {
                event = "garage:policemenu"
            }
        },
        {
            header = 'Challenger',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "INIT",
                    vehicle = Config.DepartmentVehicles.INIT.Challenger,
                }
            }
        },
        {
            header = 'Mustang',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "INIT",
                    vehicle = Config.DepartmentVehicles.INIT.Mustang,
                }
            }
        },
        {
            header = 'Corvette',
            params = {
                event = "policegarage:spawnVehicle",
                args = {
                    Department = "INIT",
                    vehicle = Config.DepartmentVehicles.INIT.Corvette,
                }
            }
        },
    })
end)

RegisterNetEvent('garage:policemenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Police Garage',
            params = {
                event = "garage:policemenu"
            }
        },
        {
            header = 'LSPD',
            params = {
                event = "qb-menu:client:lspd",
                args = {
                    number = 1, 2,
                }
            }
        },
        {
            header = 'BCSO',
            params = {
                event = "qb-menu:client:bcso",
                args = {
                    number = 1, 2,
                }
            }
        },
        {
            header = 'SAST',
            params = {
                event = "qb-menu:client:sast",
                args = {
                    number = 1, 2,
                }
            }
        },
        {
            header = 'Interceptors',
            params = {
                event = "qb-menu:client:interceptor",
                args = {
                    number = 1, 2,
                }
            }
        },
        {
            header = 'Store Vehicle',
            params = {
                event = "policegarage:storecar",
                args = {}
            }
        },
        {
            header = 'X Close',
            params = {
                event = "qb-menu:closeMenu",
                args = {}
            }
        },
    })
end)
