# Documentation

Activity detection uses the player's head rotation to determine activity. If the
horizontal angle of the head changes, it is counted as activity. The player
joining the game is also counted as activity.

## Overview

By default, if the head rotation stays the same for **3600** ticks, players are
tagged with `afk`, then the `#afk:away` function tag is executed. When the
player next rotates their head, the `#afk:back` tag is executed _before_ the
number of ticks the player has been inactive for is cleared.

The API documentation in the next section contains further information.

Below is a very simple datapack that kicks AFK players if they aren't
spectators.

**kick-afk-players/data/afk/tags/functions/away.json**

```json
{ "values": ["afk_kick:kick"] }
```

**kick-afk-players/data/afk_kick/functions/kick.mcfunction**

```mcfunction
execute if entity @s[gamemode=!spectator] run kick @s AFK
```

## Public API Documentation

The public API of this data pack is stable, and intentionally quite small,
consisting of 2 function tags, 3 scoreboards objectives, and 1 entity tag. The
statements below are the guarantees implied by the current version of the data
pack, with the normal backwards compatibility guarantees of semantic versioning:
minor versions may introduce new features, but will not introduce breaking
changes.

---

### Function tags

#### `#afk:away`

**Added in version 1.0**

This function tag is executed as the player that has gone AFK when they receive
their `afk` tag. This is guaranteed to be called after the player has been
tagged as `afk` and after their `afk.ticks` value has reached the threshold.

This is not guaranteed to be executed only once per player before `#afk:back` is
executed, as if the `afk` tag is removed by another player without altering the
`afk.ticks` value, they will be tagged again and this function tag will be
called. As such, functions registered to this tag should be idempotent - that
is, multiple executions should not stack side effects.

#### `#afk:back`

**Added in version 1.0**

This funcitoen tag is executed as the player that has stopped being AFK when
their `afk` tag is removed. This is guaranteed to be called after the `afk` tag
has been removed, and before the player's `afk.ticks` value has been reset to 0.

If side effects are applied from `#afk:away`, this function tag allows you to
revert them as it is guaranteed to be called for every player that goes AFK. It
is not guaranteed to be executed during the same "play session", i.e. the player
may have logged out and logged back in. (To detect this, see the scoreboard
objective `afk.left_game`).

---

### Scoreboard objectives

#### `afk`

**Added in version 1.2**

Trigger scoreboard that allows players to manually become AFK, if enabled by a
server operator.

To enable a player, use the `scoreboard players enable` command:

```mcfunction
/scoreboard players enable @s afk
```

The scoreboard is then used with the trigger command:

```mcfunction
/trigger afk
```

This is not enabled for any players by default because it has the potential for
abuse, such as spamming chat messages with AFK Message.

#### `afk.settings`

**Added in version 1.2**

Any configuration for this datapack. New values may be introduced in the future.

This scoreboard is mutable but should not be used to store any external state.
Addons should maintain their own settings.

- **`.threshold`**
  - The number of ticks of inactivity it takes for a player to be counted as
    AFK.
  - This is set to **3600** by default: long enough to pee, but not long enough
    to poop.
  - `/scoreboard players set .threshold afk.settings NUMBER_OF_TICKS`

#### `afk.ticks`

**Added in version 1.2**

The number of ticks that a player has been detected as inactive. The value is
not guaranteed to increment by a stable amount between different data pack
versions.

<details>
<summary>Example converting ticks to h:m:s</summary>

The example below converts the time inactive to hours, minutes, and seconds. To
get the _total_ number for any of these values, remove the modulo operation.

```mcfunction
scoreboard objectives add constant dummy
scoreboard players set #hour constant 72000
scoreboard players set #minute constant 1200
scoreboard players set #second constant 20

scoreboard objectives add hours_inactive dummy
scoreboard objectives add minutes_inactive dummy
scoreboard objectives add seconds_inactive dummy

# Get the total number of hours
scoreboard players operation @s hours_inactive = @s afk.ticks
scoreboard players operation @s hours_inactive /= #hour constant

# Get the number of minutes within an hour
scoreboard players operation @s minutes_inactive = @s afk.ticks
scoreboard players operation @s minutes_inactive %= #hour constant
scoreboard players operation @s minutes_inactive /= #minute constant

# Get the number of seconds within a minute, e.g. if inactive for
# 3m21s, the value will be 21.
scoreboard players operation @s minute_seconds_inactive = @s afk.ticks
scoreboard players operation @s minute_seconds_inactive %= #minute constant
scoreboard players operation @s minute_seconds_inactive /= #second constant
```

</details>

#### `afk.left_game`

**Added in version 1.2**

When a function has been invoked by either `#afk:away` or `#afk:back`, the
player will have a value of 0 if they have not left while AFK or greater than 0
if they have. If AFK, the player is guaranteed to have a value for this
objective.

If the player being checked is **not** tagged as AFK, they may have any value
for this objective. Their value should not be used for anything if the player is
not tagged as `afk`.

This allows you to check for uninterrupted AFK sessions and change the execution
based on that. As an example, afk-message does not send a message to announce a
player returning if the player has just joined the game.

The player will have a value of the number of times they have left since
becoming AFK. To execute if the player has left, always match on `1..` to avoid
possible edge-cases where the player joins and immediately leaves.

Example: A function registered to `#afk:back`

```mcfunction
execute if score @s afk.left_game matches 1.. run say Last session ended while AFK
execute if score @s afk.left_game matches 0 run say Returned in the same session
```

---

### Scoreboard tags

#### ️`afk`

**Added in version 1.0**

This tag, when applied to players, indicates that said player is "away".

This tag is managed by this data pack, and should not be added to any players,
or removed from any players, by any external data pack or add-on.

The presence of this tag controls whether the function tags should be executed
as the player it is applied to. As players may end up removing this tag from
another player manually, functions registered to `afk:away` and `afk:back`
should be idempotent (state changes due to being called repeatedly should result
in the same output state).
