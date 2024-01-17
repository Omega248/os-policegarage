
# Police Garage for QBcore

This is a Police Garage script for QBcore, which enables the spawning of police vehicles with the proper mods, extras, and liveries, and includes rank/grade checks that can be enabled or disabled. It comes with a config.lua file, making everything as easy as possible to edit.

## Installation

1. Download the script files and place them in your server's resources folder.

2. In the `config.lua` file, replace the default vehicle models with the police car models you want to use.

## Configuration

### Extras

To configure extras for each police department's vehicles, use the following format in the `Config.DepartmentVehicles` section of the `config.lua` file:

```lua
extras = {
    { id = 1, enabled = 0 }, // Extra 1 (enabled)
    { id = 2, enabled = 1 }, // Extra 2 (disabled)
    // Add more extras as needed
}
```

### Mods

For vehicle mods, edit the mods section in the `config.lua` file. Use this format:

```lua
mods = {
    { id = 0, modenabled = -1 }, // Spoiler, Stock
    { id = 1, modenabled = 0 },  // Bumper_F, Level 1
    // Add more mods as needed
}
```

The `modenabled` field uses these values:

- Stock: -1
- Level 1: 0
- Level 2: 1
- and so on...

### Mod Types

Here are the available mod types along with their corresponding IDs:

Mod Types
- VMT_SPOILER = 0,
-        VMT_BUMPER_F = 1,
-        VMT_BUMPER_R = 2,
-        VMT_SKIRT = 3,
-        VMT_EXHAUST = 4,
-        VMT_CHASSIS = 5,
-        VMT_GRILL = 6,
-        VMT_BONNET = 7,
-        VMT_WING_L = 8,
-        VMT_WING_R = 9,
-        VMT_ROOF = 10,
-        VMT_ENGINE = 11,
-        VMT_BRAKES = 12,
-        VMT_GEARBOX = 13,
-        VMT_HORN = 14,
-        VMT_SUSPENSION = 15,
-        VMT_ARMOUR = 16,
-        VMT_NITROUS = 17,
-        VMT_TURBO = 18,
-        VMT_SUBWOOFER = 19,
-        VMT_TYRE_SMOKE = 20,
-        VMT_HYDRAULICS = 21,
-        VMT_XENON_LIGHTS = 22,
-        VMT_WHEELS = 23,
-        VMT_WHEELS_REAR_OR_HYDRAULICS = 24,
-        VMT_PLTHOLDER = 25,
-        VMT_PLTVANITY = 26,
-        VMT_INTERIOR1 = 27,
-        VMT_INTERIOR2 = 28,
-        VMT_INTERIOR3 = 29,
-        VMT_INTERIOR4 = 30,
-        VMT_INTERIOR5 = 31,
-        VMT_SEATS = 32,
-        VMT_STEERING = 33,
-        VMT_KNOB = 34,
-        VMT_PLAQUE = 35,
-        VMT_ICE = 36,
-        VMT_TRUNK = 37,
-        VMT_HYDRO = 38,
-        VMT_ENGINEBAY1 = 39,
-        VMT_ENGINEBAY2 = 40,
-        VMT_ENGINEBAY3 = 41,
-        VMT_CHASSIS2 = 42,
-        VMT_CHASSIS3 = 43,
-        VMT_CHASSIS4 = 44,
-        VMT_CHASSIS5 = 45,
-        VMT_DOOR_L = 46,
-        VMT_DOOR_R = 47,
-        VMT_LIVERY_MOD = 48,
-        VMT_LIGHTBAR = 49,

### Colors

You can specify vehicle colors using color codes. For example, 111 represents Metallic White, and 0 represents Metallic Black. Find more color codes in the [Vehicle Colors Wiki](https://wiki.rage.mp/index.php?title=Vehicle_Colors).

## Usage

- Configure the `config.lua` file with your desired vehicle models, extras, mods, and colors.
- Ensure that your server resources are correctly configured to include this script.
- Use the garage to spawn police vehicles with the specified customizations.

## Credits

This Police Garage script was created by OmegaScripts.

For any questions or issues, please contact me on [Discord](https://discord.gg/VBsUZXWRMj).

