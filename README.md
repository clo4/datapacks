# Detect AFK Players (and all its first-party add-ons)

A simple way to detect AFK players for vanilla or modded servers, which allows
you to build additional social signalling mechanics and improve the experience
for all players.

Players are marked as AFK (`afk`) after 3 minutes of without moving the mouse.

It's easy to integrate with, too! AFK players are tagged as `afk`, and you can
use the `#afk:away` and `#afk:back` function tags to implement your own
functions.

This is a server utility. I value composability over functionality, preferring
to have less built in to the datapack and allowing you to build the features you
need on top of it. If you don't want announcements, or sleeping, or _whatever_,
you can just pick the features you _do_ want and use them without any issues or
having to edit a complicated mess while trying to remove them from an existing
datapack. Instead, each piece of functionality is self contained and performant.

## Table of Contents

- [Detect AFK Players (and all its first-party add-ons)](#detect-afk-players-and-all-its-first-party-add-ons)
  - [Table of Contents](#table-of-contents)
  - [Datapacks](#datapacks)
    - [Detect AFK Players](#detect-afk-players)
    - [AFK Sleep: Sleep while players are AFK](#afk-sleep-sleep-while-players-are-afk)
    - [AFK Message: Announce status to server](#afk-message-announce-status-to-server)
    - [AFK Dim Names: Color names of AFK players](#afk-dim-names-color-names-of-afk-players)
  - [Documentation](#documentation)
  - [Contributing](#contributing)

## Datapacks

### Detect AFK Players

[View on Modrinth](https://modrinth.com/datapack/detect-afk)

The base **afk** datapack implements the AFK detection behavior, acting as a
library for other datapacks. Players are treated as AFK after not touching the
mouse for between 180 and 185 seconds (about 3 minutes).

This datapack also gives players the `afk` tag when they become AFK, and removes
it when they return. This allows you to detect AFK players without having to
install any other datapacks, making it very easy to integrate with.

### AFK Sleep: Sleep while players are AFK

[View on Modrinth](https://modrinth.com/datapack/afk-sleep)

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

### AFK Message: Announce status to server

[View on Modrinth](https://modrinth.com/datapack/afk-message)

Using this datapack will announce to all players on the server when someone
becomes AFK or returns to the game.

### AFK Dim Names: Color names of AFK players

[View on Modrinth](https://modrinth.com/datapack/afk-dim-names)

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

As the pack is right now, I don't need anything more from it myself, and I don't
find myself motivated to work on things that I don't need. If you have some
ideas for additional functionality, you're welcome to contribute it!

If you're on an operating system where bash is available, the build script is
executable as `./build.sh`. All the required development tools are included in
the Nix flake via `nix develop` (but if you're not using Nix, make sure you have
`jq` and `zip` available). Data files are formatted with Prettier.
