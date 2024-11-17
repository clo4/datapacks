# Documentation

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

## API docs for add-ons

The public API of this data pack is stable. The statements below are the guarantees implied by the current version of the data pack, with the normal backwards compatibility guarantees of semantic versioning.

- **Tags**
  - `afk`
    - This tag, when applied to players, indicates that said player is "away".
    - This tag is managed by this data pack, and should not be added to any entities, or removed from any entities, by any external data pack or add-on.
- **Scoreboards**
  - `afk.settings`
    - Any configuration for this datapack. New values may be introduced in the future.
    - This scoreboard is mutable but should not be used to store any external state. Addons should maintain their own settings.
    - **Known keys**
      - `.ticks_inactive`
        - The number of ticks it takes for a player to be counted as AFK.
        - This is set to **3600** by default.
  - `afk.ticks_inactive`
    - The number of ticks that a player has been detected as inactive.
- **Function tags**
  - `afk:away`
    - Called as the player that has gone AFK. This is guaranteed to happen after the player has been tagged as `afk`.
  - `afk:back`
    - Called as the player that has stopped being AFK. This is guaranteed to happen after the `afk` tag has been removed.
