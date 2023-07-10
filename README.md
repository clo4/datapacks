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

## Datapacks

### afk

The base **afk** datapack implements the AFK behavior, acting as a library for
other datapacks. Players are treated as AFK after not touching the mouse for
between 180 and 185 seconds (about 3 minutes).

This datapack also gives non-spectator players the `afk` tag when they become
AFK, and removes it when they return. This allows you to detect AFK players
without having to install any other datapacks, making it very easy to integrate
with.

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

###### kick-afk-players/data/afk/tags/functions/away.json

```json
{ "values": ["afk_kick:kick"] }
```

###### kick-afk-players/data/afk_kick/functions/kick.mcfunction

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
- Performance improvements. NBT is only checked once per player every 100 ticks, maybe you can do even better or optimize something else!
- Configuration
