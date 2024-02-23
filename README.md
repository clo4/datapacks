# afk, a Minecraft datapack to detect AFK players

A simple way to detect AFK players for **vanilla** or **lightly modded**
servers, or to **integrate with other datapacks**.

Players are marked as AFK (`afk`) after 3 minutes of without moving the mouse.

> **Why did I make this?** I needed this to toggle `doDaylightCycle` when either
> no players are on, or all players are AFK. There's no good and _simple_
> solution, so I made one.

It's easy to integrate with too! AFK players are tagged as `afk`, and you can
use the `#afk:away` and `#afk:back` function tags to implement your own
functions.

This repository contains optional add-on datapacks, such as
[announcing player status to the server](#afk-announce-announce-status-to-server)
and [coloring AFK player names gray](#afk-team-color-names-of-afk-players).

## Table of Contents

- [afk, a Minecraft datapack to detect AFK players](#afk-a-minecraft-datapack-to-detect-afk-players)
  - [Table of Contents](#table-of-contents)
  - [Datapacks](#datapacks)
    - [afk](#afk)
    - [afk-sleep: Sleep while players are AFK](#afk-sleep-sleep-while-players-are-afk)
    - [afk-announce: Announce status to server](#afk-announce-announce-status-to-server)
    - [afk-team: Color names of AFK players](#afk-team-color-names-of-afk-players)
  - [Documentation](#documentation)
  - [Contributing](#contributing)

## Datapacks

### afk

The base **afk** datapack implements the AFK behavior, acting as a library for
other datapacks. Players are treated as AFK after not touching the mouse for
between 180 and 185 seconds (about 3 minutes).

This datapack also gives non-spectator players the `afk` tag when they become
AFK, and removes it when they return. This allows you to detect AFK players
without having to install any other datapacks, making it very easy to integrate
with.

### afk-sleep: Sleep while players are AFK

Changes the `playersSleepingPercentage` to allow sleeping while there are AFK
players on the server.

When the datapack is initially installed, the `playersSleepingPercentage` is
stored and used as _the percentage of players that aren't AFK_ that need to
sleep for a night to pass.

| Players online | Players not AFK | Initial playersSleepingPercentage | Players required to pass a night |
| -------------- | --------------- | --------------------------------- | -------------------------------- |
| 3              | 3               | 100%                              | 3                                |
| 3              | 2               | 100%                              | 2                                |
| 3              | 2               | 50%                               | 1                                |

### afk-announce: Announce status to server

Using this datapack will announce to all players on the server when someone
becomes AFK or returns to the game.

![Two chat messages: "clo4_ is now AFK", and "clo4_ is no longer AFK!"](assets/afk-announce.png)

### afk-team: Color names of AFK players

Using this datapack colors the names of AFK players gray and moves them to the
bottom of the player list.

## Documentation

You can use the AFK functionality by adding functions to the `#afk:away` and
`#afk:back` function tags. Functions in both tags are called as the player at
the player's position.

The example below is a very simple datapack that kicks AFK players if they
aren't specatating.

**kick-afk-players/data/afk/tags/functions/away.json**

```json
{ "values": ["afk_kick:kick"] }
```

**kick-afk-players/data/afk_kick/functions/kick.mcfunction**

```mcfunction
execute if entity @s[gamemode=!spectator] run kick @s AFK
```

## Contributing

I don't need anything more from this datapack myself, but I'm happy to add
additional features and accept pull requests containing simple or useful
features or add-ons!

If you're interested in contributing, some stuff you might be interested in
adding is:

- More examples and simple packs. I'd love to see some cool uses for this.
- Performance improvements. NBT is only checked once per player every 100 ticks,
  maybe you can do even better or optimize something else!
- Configuration
