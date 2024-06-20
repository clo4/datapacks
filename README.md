# clo4's Minecraft datapacks

Collection of all of my datapacks. These are typically focused on SMP server
administration because that's what I find myself needing more tooling for.

Keeping everything in the same repository makes it easier to build stuff fast!

## Table of Contents

- [clo4's Minecraft datapacks](#clo4s-minecraft-datapacks)
  - [Table of Contents](#table-of-contents)
  - [Datapacks](#datapacks)
    - [Pause Day Cycle](#pause-day-cycle)
    - [Chickenfix](#chickenfix)
    - [Detect AFK Players](#detect-afk-players)
      - [Documentation](#documentation)
    - [AFK Sleep](#afk-sleep)
    - [AFK Message](#afk-message)
    - [AFK Dim Names](#afk-dim-names)
  - [Nix Build System](#nix-build-system)
  - [Contributing](#contributing)

## Datapacks

### Pause Day Cycle

[View and download on Modrinth](https://modrinth.com/datapack/pause-day-cycle)

A very lightweight datapack that disables `doDaylightCycle` when nobody is
online or everyone online is tagged as `afk` (see #detect-afk-players). It's
best suited for small to medium sized servers where there are large stretches of
time that nobody will be online, or long periods where players may be AFK (eg.
at a mob grinder overnight). This is to prevent the local difficulty and day
count from becoming excessive and not representative of the amount of time that
players have actually played on the server.

The following gamerules are affected:

- `doDaylightCycle`
- `doWeatherCycle`

The gamerule `mobSpawning` is unaffected to allow mob grinders and automatic
farms to function with nobody present or an AFK player loading the chunk.

You can hook into the pause and resume events using the `pause_day_cycle:pause`
and `pause_day_cycle:resume` function tags, which will be called whenever the
day cycle pauses or resumes.

### Chickenfix

[View and download on Modrinth](https://modrinth.com/datapack/chickenfix)

A simple but effective brute force fix to chickens suffocating in walls when
they grow up in a cramped, inhumane chicken farm.

It works by teleporting chickens to the center of the block they're in, on the
tick where they grow into an adult. This prevents them from being shoved into a
wall and suffocating. This is only done if the chicken is withing five blocks of
any entity named exactly `chickenfix`, to prevent normal (humane) chicken farms
from being broken by the same logic that fixes the inhumane ones.

### Detect AFK Players

[View and download on Modrinth](https://modrinth.com/datapack/detect-afk)

A simple way to detect AFK players for vanilla or modded servers, which allows
you to build additional social signalling mechanics and improve the experience
for all players.

Players are marked as AFK (`afk`) after 3 minutes of without moving the mouse.

The base **afk** datapack implements the AFK detection behavior, acting as a
library for other datapacks. Players are treated as AFK after not touching the
mouse for between 180 and 185 seconds (about 3 minutes).

This datapack also gives players the `afk` tag when they become AFK, and removes
it when they return. This allows you to detect AFK players without having to
install any other datapacks, making it very easy to integrate with.

#### Documentation

Information on how to integrate with Detect AFK Players is in
[afk/README.md](./afk/README.md). There are example datapacks below, which also
contain examples of the functionality you can build.

### AFK Sleep

[View and download on Modrinth](https://modrinth.com/datapack/afk-sleep)

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

### AFK Message

[View and download on Modrinth](https://modrinth.com/datapack/afk-message)

Using this datapack will announce to all players on the server when someone
becomes AFK or returns to the game.

### AFK Dim Names

[View and download on Modrinth](https://modrinth.com/datapack/afk-dim-names)

Using this datapack colors the names of AFK players gray and moves them to the
bottom of the player list.

## Nix Build System

The build system is a reusable component built with Nix. You can use this
repository as an input to your own if you would like to use the same logic to
build. It would be relatively easy to extend to build a project using the Beet
toolchain, too.

Run this command to generate a flake with a single data pack in the repository
root.

```bash
nix flake init -t github:clo4/datapacks
```

Run this command to generate a flake with multiple data packs in subdirectories.

```bash
nix flake init -t github:clo4/datapacks#monorepo
```

## Contributing

The datapacks are built using Nix. You must have Nix installed if you want to
build locally. If you've never used it before, it's really not as scary as it
sounds - just [install Nix](https://install.determinate.systems/), and run
`nix build` to build all the datapacks, or to build an individual datapack, run
`nix build .#<name>` where `<name>` is something like `afk` or
`pause-day-cycle`. However, if you're on Windows, to use Nix you'll have to use
WSL, which can be a bit of a pain for doing stuff on your local Windows file
system too - I don't really have a good solution for you, but this project does
use GitHub Actions to build the project in CI and publishes an artifact from
that.

### Philosophy

I value composability over functionality, preferring to have less built in to
datapacks and allowing you to build the features you need on top of it. Each
piece of functionality can be small and performant, and they can be combined
together to create something more complicated without sacrificing on
maintainability or performance.

I only work on what I feel motivated to work on, because this isn't my job. I
just do it for fun and to make my own life easier. But if there's a feature that
you want added, you're welcome to create an issue for it and I'll take a look,
I'll build it if I think it's worth the time. Or you can contribute it yourself,
and we'll get it merged and released!
