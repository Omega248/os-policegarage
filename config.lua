-- ===================================================
--  POLICE DEPARTMENT VEHICLES CONFIGURATION FILE
-- ===================================================

Config = {}

-- ===================================================
-- | NPC CONFIGURATION                               |
-- ===================================================
-- Sets the model for NPC.
Config.NPCmodel = 'ig_trafficwarden'
-- Sets the NPC Location NPC.
Config.NPClocation = vector4(459.6, -986.6, 24.7, 90.88)
-- ===================================================
-- | FUEL SYSTEM CONFIGURATION                       |
-- ===================================================
-- Specifies the fuel system script used by vehicles.
Config.FuelSystem = 'LegacyFuel'

-- Enable or disable vehicle restriction based on job grade/rank.
Config.RestrictVehicles = true

-- ===================================================
-- | VEHICLE SPAWN LOCATIONS                         |
-- ===================================================
-- Defines coordinates (x, y, z) and headings (h) for vehicle spawn locations.
-- These locations are used to find an empty parking spot for spawning vehicles.
Config.VehSpawnLocations = {
    vector4(450.07, -975.77, 25.37, 90.07),
    vector4(435.0, -975.85, 25.37, 90.34),
    vector4(445.97, -986.17, 25.36, 271.1),
    vector4(445.71, -988.8, 25.36, 270.33),
    vector4(445.5, -991.53, 25.36, 268.99),
    vector4(445.78, -994.24, 25.36, 269.81),
    vector4(446.04, -996.93, 25.36, 269.92),
    vector4(437.3, -986.19, 25.36, 89.25),
    vector4(437.19, -988.9, 25.36, 89.31),
    vector4(437.29, -991.52, 25.36, 90.81),
    vector4(437.31, -994.34, 25.36, 90.32),
    vector4(437.35, -996.88, 25.36, 91.3),
    vector4(425.58, -997.12, 25.36, 271.6),
    vector4(425.92, -994.32, 25.36, 270.71),
    vector4(425.58, -991.66, 25.36, 270.16),
    vector4(425.88, -989.02, 25.36, 270.64),
    vector4(425.76, -984.25, 25.36, 271.54),
    vector4(425.83, -981.54, 25.36, 270.15),
    vector4(425.69, -978.88, 25.36, 270.17),
    vector4(425.75, -976.12, 25.36, 269.31)
}

-- ===================================================
-- | DEPARTMENT VEHICLES CONFIGURATION               |
-- ===================================================
-- Configuration for each police department's vehicles.
-- Includes settings for vehicle models, colors, liveries, rank requirements,
-- modifications, and additional features.

-- Key Fields:
--  model: The in-game model name of the vehicle.
--  label: A friendly name for the vehicle.
--  primarycolor: The primary color ID of the vehicle.
--  secondarycolor: The secondary color ID of the vehicle.
--  livery: The livery ID of the vehicle.
--  rank: The job grade required for the vehicle if Config.RestrictVehicles is true.
--  mods: Modifications available for the vehicle.
--  extras: Additional features for the vehicle. In 'extras', 0 is enabled and 1 is disabled.
-- Vehicle configurations for LSPD, BCSO, SAST, INIT, etc., are defined here...
Config.DepartmentVehicles = {
    LSPD = {-- Los Santos Police Department (LSPD)
        Charger = {
            model = "char", -- Actual Charger model name
            label = "LSPD Charger",
            primarycolor = 111,
            secondarycolor = 0,
            livery = 2,
            rank = 2,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        CVPI = {
            model = "pd1", -- Actual CVPI model name
            label = "LSPD CVPI",
            primarycolor = 0,
            secondarycolor = 111,
            livery = 0,
            rank = 0,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        Explorer = {
            model = "Explorer", -- Actual Explorer model name
            label = "LSPD Explorer",
            primarycolor = 0,
            secondarycolor = 111,
            livery = 1,
            rank = 1,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        -- Additional LSPD vehicles...
    },
    BCSO = {-- Blaine County Sheriff's Office (BCSO)
        Charger = {
            model = "char", -- Actual Charger model name
            label = "BCSO Charger",
            primarycolor = 111,
            secondarycolor = 49,
            livery = 0,
            rank = 2,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        CVPI = {
            model = "pd1", -- Actual model name
            label = "BCSO CVPI",
            primarycolor = 111,
            secondarycolor = 49,
            livery = 3,
            rank = 0,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        Explorer = {
            model = "explorer", -- Actual Explorer model name
            label = "BCSO Explorer",
            primarycolor = 49,
            secondarycolor = 111,
            livery = 2,
            rank = 1,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        -- Additional BCSO vehicles...
    },
    SAST = {-- San Andreas State Troopers (SAST)
        Charger = {
            model = "char", -- Actual Charger model name
            label = "SAST Charger",
            primarycolor = 4,
            secondarycolor = 4,
            livery = 3,
            rank = 2,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        CVPI = {
            model = "pd1", -- Actual CVPI model name
            label = "SAST CVPI",
            primarycolor = 4,
            secondarycolor = 4,
            livery = 2,
            rank = 0,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        Explorer = {
            model = "Explorer", -- Actual Explorer model name
            label = "SAST Explorer",
            primarycolor = 4,
            secondarycolor = 4,
            livery = 4,
            rank = 1,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        -- Additional SAST vehicles...
    },
    INIT = {-- Interceptors (INIT)
        Mustang = {
            model = "mach1rb", -- Actual Mustang model name
            label = "Interceptor Mustang",
            primarycolor = 49,
            secondarycolor = 111,
            livery = 2,
            rank = 3,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        Corvette = {
            model = "zr1RB", -- Actual Corvette model name
            label = "Interceptor Corvette",
            primarycolor = 49,
            secondarycolor = 111,
            livery = 2,
            rank = 3,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        Challenger = {
            model = "poldemonrb", -- Actual Challanger model name
            label = "Interceptor Challanger",
            primarycolor = 49,
            secondarycolor = 111,
            livery = 2,
            rank = 3,
            mods = {
                { id = 0, modenabled = -1 }, -- id 0 represents the Spoiler modification. The 'modenabled' field uses -1 for level 0, 0 for level 1, and so on.
            },
            extras = {
                { id = 1, enabled = 0 }, -- For vehicle extras, '0' indicates enabled, and '1' indicates disabled.
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
                { id = 4, enabled = 0 },
                { id = 5, enabled = 0 },
                { id = 6, enabled = 0 },
                { id = 7, enabled = 0 },
                { id = 8, enabled = 0 }
            }
        },
        -- Additional INIT vehicles...
    },
    -- Additional departments if needed...
}
