# Stoic Mechanic Resource
![20240118_235348_0000](https://github.com/TheStoicBear/Stoic-Mechanic/assets/112611821/3acb2b59-2284-4642-b802-62244597b047)

This Mechanic resource is a FiveM resource designed to simulate vehicle repair and maintenance for role-playing servers. Mechanics and players can use this resource to repair and maintain vehicles within the game.

## Features

- **Vehicle Repair:** Players can repair damaged vehicles using a predefined animation and time delay.
- **Raise and Lower Vehicles:** Mechanics can raise vehicles for inspection and lower them after repairs.
- **Doors & Wheels Exhange:** Provides realistic replacement body parts, removes doors, hood, trunk, and wheels. Then replaces them with new parts.
- **Realistic Animations:** Provides a realistic "MEDIC TEND" animation when repairing vehicles.
- **Notifications:** Includes customizable chat bubble notifications for various actions.
- ~~**Airbag Removal:** Allows the removal of airbags from vehicles when repairing.~~
-  **Invoices:** Payment for new parts via deduction of money [ND_Core](https://github.com/ND-Framework/ND_Core) can be changed in `server.lua`.

## Installation

1. Download the `Stoic-Mechanic` resource from the GitHub repository.
2. Place it in your FiveM server's resource directory.

```
/resources/Bears-Mechanic
```
3. Add `ensure Stoic-Mechanic` to your server.cfg file.

## Configuration
The resource can be configured to your liking. Edit the config.lua file to modify settings such as animation duration, success chance, and more.
```
Config = {
    -- URL for the Mech logo
    MechLogoURL = 'https://static.wikia.nocookie.net/gtawiki/images/9/92/LSCustoms-GTAV-Logo2.png/revision/latest?cb=20150530220533', -- Replace with the actual URL of your Mech logo

    -- Adjust the success chance for tire and car repair (0.0 to 1.0)
    SuccessChance = 0.8,

    -- Enable or disable Ace permissions for the commands
    UseAcePerms = false, -- Set to true to use Ace permissions, false to disable

    -- Define Ace permission for using the repair functions
    MechPermission = "codex:mech", -- Make sure this matches your Ace permission setup

    -- Notification messages
    Notifications = {
        Raising = "Raising the car...", -- Message when raising the car
        Fixing = "Repairing the vehicle...", -- Message when repairing the vehicle
        Lowering = "Lowering the car...", -- Message when lowering the car
        Success = "Vehicle repaired successfully!", -- Message for successful repair
        Failure = "Vehicle repair failed." -- Message for failed repair
    }
}
```

## Notifications
Customizable chat bubble notifications are provided for various actions:

- Raising the car
- Lowering the car
- Repairing the vehicle (success and failure)
...
You can customize the notification messages in the config.lua file.


## ~~Removing Airbags~~
~~The resource includes functionality to remove airbags from vehicles when repairing them. Refer to the code to see how airbags are removed.~~


## Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:


## Fork the repository.
1. Create a new branch for your feature or bug fix.
2. Make your changes and test thoroughly.
3. Create a pull request.


##License
This resource is licensed under the MIT License. See the LICENSE file for details.

Credits
[TheStoicBear](https://github.com/TheStoicBear) - Developer
[Car Lift](https://forum.cfx.re/u/bcs19/summary)
