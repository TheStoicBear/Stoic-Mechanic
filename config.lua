Config = {
    -- URL for the Mech logo
    MechLogoURL = 'https://static.wikia.nocookie.net/gtawiki/images/9/92/LSCustoms-GTAV-Logo2.png/revision/latest?cb=20150530220533', -- Replace with the actual URL of your Mech logo

    -- Adjust the success chance for tire and car repair (0.0 to 1.0)
    SuccessChance = 0.8,
    repairTime = 30 * 1000, -- Convert seconds to milliseconds
    -- Enable or disable Ace permissions for the commands
    UseAcePerms = false, -- Set to true to use Ace permissions, false to disable
    UseND = true,
    -- Define Ace permission for using the repair functions
    MechPermission = "codex:mech", -- Make sure this matches your Ace permission setup
        MechJob = {
            "LSDOT",
            "LSDOT",
            "CIV"
        },
    -- Notification messages
    Notifications = {
        Raising = "Raising the car...", -- Message when raising the car
        Fixing = "Repairing the vehicle...", -- Message when repairing the vehicle
        Lowering = "Lowering the car...", -- Message when lowering the car
        Success = "Vehicle repaired successfully!", -- Message for successful repair
        Failure = "Vehicle repair failed." -- Message for failed repair
    },
    -- Zone configurations
    Zones = {
        RepairShop1 = {
            coords = vector3(-1155.0, -2007.0, 13.0), -- LSC by airport
            radius = 25.0,
        },
        RepairShop2 = {
            coords = vector3(734.0, -1085.0, 22.0), -- LSC La Mesa
            radius = 25.0,
        },
        RepairShop3 = {
            coords = vector3(1177.0, 2640.0, 37.0), -- LSC Harmony
            radius = 25.0,
        },
        RepairShop4 = {
            coords = vector3(108.0, 6624.0, 31.0), -- LSC Paleto Bay
            radius = 25.0,
        },
        RepairShop5 = {
            coords = vector3(538.0, -183.0, 54.0), -- Mechanic Hawic
            radius = 18.0,
        },
        RepairShop6 = {
            coords = vector3(1774.0, 3333.0, 41.0), -- Flywheels Sandy
            radius = 15.0,
        },
        RepairShop7 = {
            coords = vector3(1143.0, -776.0, 57.0), -- Mechanic Mirror Park
            radius = 15.0,
        },
        RepairShop8 = {
            coords = vector3(2508.0, 4103.0, 38.0), -- Mechanic East Joshua Rd.
            radius = 30.0,
        },
        RepairShop9 = {
            coords = vector3(484.0, -1316.0, 29.0), -- Hayes Auto, Little Bighorn Ave.
            radius = 25.0,
        },
        RepairShop10 = {
            coords = vector3(-1419.0, -450.0, 36.0), -- Hayes Auto Body Shop, Del Perro
            radius = 33.0,
        },
        RepairShop11 = {
            coords = vector3(268.0, -1810.0, 27.0), -- Hayes Auto Body Shop, Davis
            radius = 33.0,
        },
        RepairShop12 = {
            coords = vector3(1915.0, 3729.0, 32.0), -- Otto's Auto Parts, Sandy Shores
            radius = 27.0,
        },
        RepairShop13 = {
            coords = vector3(-29.0, -1665.0, 29.0), -- Mosley Auto Service, Strawberry
            radius = 45.0,
        },
        RepairShop14 = {
            coords = vector3(-212.0, -1378.0, 31.0), -- Glass Heroes, Strawberry
            radius = 44.0,
        },
        RepairShop15 = {
            coords = vector3(258.0, 2594.0, 44.0), -- Mechanic Harmony
            radius = 33.0,
        },
        RepairShop16 = {
            coords = vector3(-32.0, -1090.0, 26.0), -- Simeons
            radius = 18.0,
        },
        RepairShop17 = {
            coords = vector3(-211.0, -1325.0, 31.0), -- Bennys
            radius = 25.0,
        },
        RepairShop18 = {
            coords = vector3(725.0, 4181.0, 40.0), -- Hidden Mechanic
            radius = 25.0,
        },
        GasStation = {
            coords = vector3(-200.0, -800.0, 30.0),
            radius = 5.0,
        },
        -- Add more zones as needed
    }
}
