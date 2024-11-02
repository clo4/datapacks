# No Free Deaths

It's `keepInventory` with consequences.

## Documentation

### Structure

I try to keep a general structure that's similar to Go.
- `cmd` for public-facing commands that users are intended to run
- `internal` for things that users shouldn't touch

Each "mechanic" is siloed into its own directory under `no_free_deaths/function/mechanic`, and by convention, the "entrypoint" is named after the tag that invoked it (e.g. `drop_xp/on_death.mcfunction`). These each create their own namespaced scoreboards on load. Each mechanic's load function is invoked by the main load function.

### How it works

`no_free_deaths` has two types of punishment: "on death" and "on respawn". These have corresponding function tags that will be called as a player. These will only be called if all the following conditions are met:
- `keepInventory` is enabled
- The player that died was not in Creative or Spectator mode

#### Detecting death

Death is detected using the `no_free_deaths:internal/player_died` advancement. This triggers a function that revokes the advancement and runs the corresponding function tag.

#### Detecting respawn

Respawn is detected by using a scoreboard and an `@e[type=minecraft:player]` selector, as this can only select living entities. When a player dies, their death count is incremented by 1, but the player cannot be selected until they respawn.
