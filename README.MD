Just a simple Police garage for qbcore includes the ability to spawn the vehicles with the proper mods, extras and liveries


![image](https://user-images.githubusercontent.com/86800507/162882056-c555a49a-afdf-4594-9c2d-c24a5514be17.png)
![image](https://user-images.githubusercontent.com/86800507/162882077-5d049856-6147-42dc-9e9d-0431c1f8ebef.png)


NPC model is the Ped model more can be found here https://docs.fivem.net/docs/game-references/ped-models/ If you change the NPC model to a female Ped model make sure you change line 46 in main.lua from NPC = CreatePed(5, hash, coords, heading, false, false) to NPC = CreatePed(4, hash, coords, heading, false, false)

You will need to replace Model(ChangeMe) to your police car model in the main.lua

EXTRAS 
for Extras change SetVehicleExtra(veh, 1, 0) 
1 is the extra and 0 = true if you want to set the extra to false then change it to 1

MODS 
for the mods SetVehicleMod(veh, 1, 2, 3) 
    Veh = Vehicle You dont need to change this 
        1 = ModType

              Mod Types
            VMT_SPOILER = 0,
            VMT_BUMPER_F = 1,
            VMT_BUMPER_R = 2,
            VMT_SKIRT = 3,
            VMT_EXHAUST = 4,
            VMT_CHASSIS = 5,
            VMT_GRILL = 6,
            VMT_BONNET = 7,
            VMT_WING_L = 8,
            VMT_WING_R = 9,
            VMT_ROOF = 10,
            VMT_ENGINE = 11,
            VMT_BRAKES = 12,
            VMT_GEARBOX = 13,
            VMT_HORN = 14,
            VMT_SUSPENSION = 15,
            VMT_ARMOUR = 16,
            VMT_NITROUS = 17,
            VMT_TURBO = 18,
            VMT_SUBWOOFER = 19,
            VMT_TYRE_SMOKE = 20,
            VMT_HYDRAULICS = 21,
            VMT_XENON_LIGHTS = 22,
            VMT_WHEELS = 23,
            VMT_WHEELS_REAR_OR_HYDRAULICS = 24,
            VMT_PLTHOLDER = 25,
            VMT_PLTVANITY = 26,
            VMT_INTERIOR1 = 27,
            VMT_INTERIOR2 = 28,
            VMT_INTERIOR3 = 29,
            VMT_INTERIOR4 = 30,
            VMT_INTERIOR5 = 31,
            VMT_SEATS = 32,
            VMT_STEERING = 33,
            VMT_KNOB = 34,
            VMT_PLAQUE = 35,
            VMT_ICE = 36,
            VMT_TRUNK = 37,
            VMT_HYDRO = 38,
            VMT_ENGINEBAY1 = 39,
            VMT_ENGINEBAY2 = 40,
            VMT_ENGINEBAY3 = 41,
            VMT_CHASSIS2 = 42,
            VMT_CHASSIS3 = 43,
            VMT_CHASSIS4 = 44,
            VMT_CHASSIS5 = 45,
            VMT_DOOR_L = 46,
            VMT_DOOR_R = 47,
            VMT_LIVERY_MOD = 48,
            VMT_LIGHTBAR = 49,

        2 = Mod 

            Stock = -1
            1 = 0
            2 = 1
            and so on

        3 = Custom Tires

            0 = true
            1 = false

Colours
    for Vehicle Colours change SetVehicleColours(veh, 111, 0)

        Veh = Vehicle
        111 = Metallic White
        0 = Metallic Black
        More colour codes can be found here https://wiki.rage.mp/index.php?title=Vehicle_Colors

To change where the car spawns change the X,Y,Z and H  at Local Coords

Depending on the Fuel System you are using you might want to change "exports['lj-fuel']:SetFuel(veh, 100.0)" to "exports['LegacyFuel']:SetFuel(veh, 100.0)"
