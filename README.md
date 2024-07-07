# Untamed Raids

Untamed Raids is a script that introduces dynamic NPC raid missions to your server. Players can initiate these raids through a configurable command and face waves of enemies in various predefined areas. Upon successful completion, players are rewarded with money, items, or both.

## Features

- **Dynamic Raid Missions**: Players can start raid missions by entering a command. Missions consist of multiple enemy encounters.
- **Configurable Areas and Waves**: Define multiple areas with different enemy waves in the configuration file.
- **Rewards System**: Players can receive money, items, or both as rewards for completing the raids. The rewards are fully configurable.
- **Notification System**: Players receive notifications about mission start, ambushes, and mission completion.

## Installation

1. **Download and Extract**: Download the script and extract it into your resources folder.

2. **Rename the Folder**: Ensure the folder is named `untamed_raids`.

3. **Add to Server Config**: Add `ensure untamed_raids` to your `resources.cfg`.

4. **Configuration**: Customize the script by editing the `config.lua` file to fit your server's needs.

## Usage

### Starting a Raid

Players can start a raid by using the configured command (default: `/getclapped <area_id>`). The `area_id` corresponds to the areas defined in the `config.lua`.

### Commands

- `/getclapped <area_id>`: Initiates a raid in the specified area.

## Contributing

If you wish to contribute to this project, feel free to fork the repository and make modifications. Pull requests are welcome!

## License

This project is licensed under the GNU General Public License. See the LICENSE file for details.

![Untamed Raids](https://imgur.com/a/t0z84BU)
