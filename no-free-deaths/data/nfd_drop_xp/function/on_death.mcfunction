# As a sanity check, if the configured drop percentage is out of bounds, it will be
# brought back within the range of allowed values. This is also done because it allows
# us to skip the work if 0% would be dropped, which is unlikely, but a possible case.
execute if score .drop_percentage no_free_deaths.drop_xp.settings matches 101.. run scoreboard players set .drop_percentage no_free_deaths.drop_xp.settings 100
execute if score .drop_percentage no_free_deaths.drop_xp.settings matches ..-1 run scoreboard players set .drop_percentage no_free_deaths.drop_xp.settings 0

# If the player has configured dropping the full amount of XP, the drop percentage will always be 100%.
# The way XP works in this game is annoying, so this is the only way to guarantee a reasonable behaviour.
execute unless score .drop_percentage no_free_deaths.drop_xp.settings matches 100 if score .drop_full_xp no_free_deaths.drop_xp.settings matches 1 run scoreboard players set .drop_percentage no_free_deaths.drop_xp.settings 100

execute unless score .drop_percentage no_free_deaths.drop_xp.settings matches 0 as @s at @s run function nfd_drop_xp:internal/apply
