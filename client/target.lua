local QBCore = exports['qb-core']:GetCoreObject()

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