# Description
This is a script for handling spatial 3D audio for FiveM, via NUI and audio files stored within the script.

# Acknowledgment
Big thanks to [ultrahacx](https://github.com/ultrahacx) and [Vasco_Ferreira](https://github.com/vferreira-git) for their resources and work with Howler that helped with my understanding of the library and motivation to further the idea. Big thanks to the other xyz devs also for keeping me motivated.

### Usage
All of the interactions with this resource can be made through server-side exports. It's important to keep the `uniqueId` for each sound source truly unique. Sound files are stored in the `html/sounds` folder and can be .ogg, .mp3, .weba format. Howler does support other formats, and to add them, you will have to expand your fxmanifest.

##### Preview:
[Youtube](https://www.youtube.com/watch?v=IOE3tu6epcA)

##### Qbus.xyz Discord:
[Discord](https://discord.gg/jTsrKaV6As)

##### Starting a sound source:
```lua
local coords = vector3(1, 1, 1)
local song = 'stay.ogg'
local volume = 1.0
local radius = 100
local uniqueId = 'boombox_42'
exports['xyz-3dsound']:Play(coords, song, volume, radius, uniqueId)
```

##### Stopping a sound source:
```lua
local uniqueId = 'boombox_42'
exports['xyz-3dsound']:Delete(uniqueId)
```

##### Pausing a sound source:
```lua
local uniqueId = 'boombox_42'
exports['xyz-3dsound']:Pause(uniqueId)
```

##### Resuming a sound source:
```lua
local uniqueId = 'boombox_42'
exports['xyz-3dsound']:Resume(uniqueId)
```

##### Updating the position of a source:
```lua
local uniqueId = 'boombox_42'
local coords = vector3(2, 2, 2)
exports['xyz-3dsound']:UpdateCoords(uniqueId, coords)
```
