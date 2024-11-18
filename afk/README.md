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

## Details

Activity detection uses two methods:

- **Checking what inputs the player is sending**
  - Forward, backward, left, right, and jump
  - Sneak and sprint cannot be used to check since they can be toggled
- **Checking if the player is both riding a boat/camel and if the entity is
  moving**
  - Boat drivers send inputs, but passengers typically don't, so this check
    essentially ties the passenger's "activity" to the driver of the boat.
  - Boats and camels do not move without player input, whereas minecarts can.

More entities could be added to the predicate in the future if necessary.

### Alternative ways to implement this (and why they're bad)

Head rotation is the most accurate way to detect activity, but at the time of
writing (1.21.3) it is not possible to do this without checking player NBT, and
is still not a flawless method. To use head rotation, the loop must be slower
and less responsive to inputs, as NBT is much more expensive to check since the
game must serialize its state for every player, as opposed to using the existing
in-memory data structures.

Other data packs that do this sometimes use X/Y/Z location, which is both
expensive (3 NBT queries, so 3 separate serializations) and inaccurate as the
location can be changed due to external factors (creeper explosions, water
streams).

Another common alternative is to use the statistic
"`minecraft.custom:minecraft.<action>_one_cm`" scoreboards, but this is also
flawed: `walk_one_cm` will increase due to knockback as a player slides on the
ground, and the water ones will increment without any input if in water.

## API docs for add-ons

The public API of this data pack is stable. The statements below are the
guarantees implied by the current version of the data pack, with the normal
backwards compatibility guarantees of semantic versioning.

---

### Scoreboard tags

#### `afk`

This tag, when applied to players, indicates that said player is "away".

This tag is managed by this data pack, and should not be added to any players,
or removed from any players, by any external data pack or add-on.

The presence of this tag controls whether the function tags should be executed
as the player it is applied to. As players may end up removing this tag from
another player manually, functions registered to `afk:away` and `afk:back`
should be idempotent (state changes due to being called repeatedly should result
in the same output state).

---

### Scoreboards

#### `afk.settings`

Any configuration for this datapack. New values may be introduced in the future.

This scoreboard is mutable but should not be used to store any external state.
Addons should maintain their own settings.

- **Known keys**
  - `.ticks`
    - The number of ticks it takes for a player to be counted as AFK.
    - This is set to **3600** by default.

#### `afk.ticks`

The number of ticks that a player has been detected as inactive.

---

### Function tags

#### `afk:away`

- Called as the player that has gone AFK.
- This is guaranteed to happen after the player has been tagged as `afk` and
  their `afk.ticks` has reached the configured threshold.
- This is not guaranteed to be executed only once per player before `afk:back`
  is executed. Functions registered to this function tag should be idempotent.

#### `afk:back`

- Called as the player that has stopped being AFK.
- This is guaranteed to happen after the `afk` tag has been removed and their
  `afk.ticks` has been set to 0.
- This is not guaranteed to be executed only once per player after `afk:away` is
  executed. Functions registered to this function tag should be idempotent.
