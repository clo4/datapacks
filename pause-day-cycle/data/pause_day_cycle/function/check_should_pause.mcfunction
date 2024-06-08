execute store result score #n_players pause_day_cycle.dummy if entity @a
# This could be changed to some other condition such as @a[gamemode=spectator]
execute store result score #n_players_afk pause_day_cycle.dummy if entity @a[tag=afk]

# This is slightly unintuitive - if there are no players online, the number of players with the
# `afk` tag is the same as the number of players online (both being 0). If there's 1 player online
# tagged `afk`, that's the same again. And If there's 1 player online that isn't `afk`, then
# the scores aren't equal and this shouldn't run.
execute if score #n_players_afk pause_day_cycle.dummy = #n_players pause_day_cycle.dummy run function pause_day_cycle:pause
