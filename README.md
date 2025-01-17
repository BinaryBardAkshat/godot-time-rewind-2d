# TimeRewind2D Plugin

This plugin adds powerful time manipulation mechanics to your Godot projects, inspired by games like *Braid*. With this plugin, you can easily integrate features like rewinding time for specific objects and altering the game's time scale in designated areas. The plugin was originally made as a submission for [Mechanically Challenged](https://itch.io/jam/mechanically-challenged-august-2024).

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
  - [RewindManager](#rewindmanager)
  - [TimeRewind2D](#timerewind2d)
  - [TimeArea2D (WIP)](#TimeArea2D)
- [License](#license)
- [Contributing](#contributing)

## Features

- **RewindManager**: This autoload script handles the global rewind process for your project. It manages when the rewind starts and stops, and it can pause other nodes that shouldn't be affected by the rewind.
  
- **TimeRewind2D**: A node that allows you to rewind specific properties of individual 2D bodies over a defined time. This is the core component of the plugin and is highly customizable.

- **TimeArea2D** (Work In Progress): This component will allow you to modify the time scale within specific areas of your game world, creating regions where time behaves differently.

## Installation

1. **Download the Plugin**:
   - Download the `TimeRewind2D` plugin from the Godot Asset Library or directly from the [Github Releases](https://github.com/ImTani/godot-time-rewind-2d/releases).

2. **Install the Plugin**:
   - Extract the downloaded files into your project's `res://addons/` directory.
   - Ensure the folder structure is as follows:
     ```
     res://addons/time_rewind_2d/
     ```

3. **Activate the Plugin**:
   - Open your Godot project.
   - Go to **Project** > **Project Settings** > **Plugins**.
   - Find `TimeRewind2D` in the list and set it to **Active**.

![TimeRewind2D Plugin Screenshot](https://raw.githubusercontent.com/ImTani/godot-time-rewind-2d/main/docs/media/plugin_window.png)

## Usage

1. **Enable the Plugin**: Once the `TimeRewind2D` plugin is enabled in your project, the `RewindManager` class becomes accessible as a singleton.
 
2. **Configure Non-Rewindable Nodes** (optional): For all nodes that you want to not be processed during the rewind (making it look like time has stopped for these nodes), in the `_ready()` function of your script, append the nodes into the `non_rewindables` array of the `RewindManager`. This ensures that these nodes will stop processing during the rewind.

   ```gdscript
   func _ready():
       RewindManager.non_rewindables.append($YourNode)
   ```

3. **Add the TimeRewind2D Node**: Place the `TimeRewind2D` node into your scene. This node is responsible for handling the rewind process for the associated `body`.

4. **Set Up the TimeRewind2D Node**:
   - Assign the `body` export to the `Node2D` you want to rewind.
   - Assign the `collision_shape` export to the corresponding `CollisionShape2D`.
   - Set the `rewind_time` to the desired duration in seconds.
   - Click on `Edit Rewinding Properties` button in the inspector to open the property selector.
   - Select all relevant properties through the selector.
   - Click confirm to save the changes.

  ![TimeRewind2D Node Screenshot](https://raw.githubusercontent.com/ImTani/godot-time-rewind-2d/main/docs/media/time_rewind_2d.png)

5. **Trigger the Rewind**: When you want to initiate the rewind during gameplay, simply call `RewindManager.start_rewind()`. This will rewind all nodes in the scene that have the `TimeRewind2D` node attached.

   ```gdscript
   func _on_some_event():
       RewindManager.start_rewind()
   ```

## Documentation

### RewindManager

The `RewindManager` is a singleton script that manages the global rewind process. It emits signals when rewinding starts and stops, and it controls which nodes should not be affected by the rewind.

- **Signals**:
  - `rewind_started`: Emitted when the rewind process starts.
  - `rewind_stopped`: Emitted when the rewind process stops.

- **Methods**:
  - `start_rewind()`: Begins the rewind process.
  - `stop_rewind()`: Ends the rewind process.

- **Properties**:
  - `is_rewinding`: A boolean indicating whether the rewind is currently active.
  - `non_rewindables`: An array of nodes that should not be affected by the rewind.

### TimeRewind2D

The `TimeRewind2D` script is attached to nodes you wish to rewind. It records the values of specified properties over time and rewinds them when triggered.

- **Properties**:
  - `body`: The main `Node2D` object whose properties will be manipulated.
  - `collision_shape`: A `CollisionShape2D` object associated with the `body`. It is automatically disabled during the rewind to avoid collisions.
  - `rewind_time`: The duration (in seconds) for how far back the properties should be rewound.
  - `rewindable_properties`: An array of strings specifying the properties of the `body` that can be rewound (e.g., `global_position`, `rotation_degrees`).

- **Methods**:
  - `_store_current_values()`: Records the current values of the specified properties.
  - `_rewind_process(delta)`: Rewinds the properties to their previous values over time.

- **Signals**:
  - The script connects to the `RewindManager` signals to start and stop the rewind process.

### TimeArea2D (WIP)

*Note: This feature is currently a work in progress.*

The `TimeArea2D` will allow you to create areas where the time scale can be altered, speeding up or slowing down the flow of time within that region.

## Examples

- [Playable Demo on Itch.io (Web Build)](https://infinitani.itch.io/time-manipulation)


## License

This plugin is licensed under the [MIT License](LICENSE). This means you are free to use, modify, and distribute the plugin as long as you include the original license file in any distribution.

## Contributing

Contributions are welcome! Feel free to submit issues and pull requests with improvements or bug fixes.