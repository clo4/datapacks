execute as @s store result score @s no_free_deaths.drop_xp.lost_levels run xp query @s levels
execute store result score @s no_free_deaths.drop_xp.lost_points run xp query @s points

# The points are always reset regardless of the type of XP drop being performed
xp set @s 0 points

# lost_levels = (player_level * percent) // 100
#
# As a special case, if the player has 1 level, they will always lose it. Mathematically
# this doesn't always make sense, but since it's the only level where you could die and
# respawn with the same number of levels, it doesn't feel right when playing.
# Since lost_levels is set to the player's XP level, if it is not touched altered,
# the player will lose that level.
# The player having 0 levels has already been handled.
execute if score @s no_free_deaths.drop_xp.lost_levels matches 2.. run scoreboard players operation @s no_free_deaths.drop_xp.lost_levels *= .drop_percentage no_free_deaths.drop_xp.settings
execute if score @s no_free_deaths.drop_xp.lost_levels matches 2.. run scoreboard players operation @s no_free_deaths.drop_xp.lost_levels /= .100 no_free_deaths.drop_xp.const

scoreboard players operation @s no_free_deaths.drop_xp.levels_to_remove = @s no_free_deaths.drop_xp.lost_levels
execute if score @s no_free_deaths.drop_xp.levels_to_remove matches 1.. as @s run function no_free_deaths:mechanic/drop_xp/internal/remove_xp

# NOTE: With doImmediateRespawn, this would be triggered *after* the player respawns, so if it is enabled,
# there isn't really a sane way to summon the XP orbs. While players do now store their last death location,
# making the XP spawn there would massively complicate the logic for something that almost nobody uses.
# However, it's important that this data pack doesn't do something very unexpected in that edge case,
# such as instantly giving the player that died their XP upon respawn.
execute store result score .do_immediate_respawn_is_enabled no_free_deaths.tmp run gamerule doImmediateRespawn

execute if score .do_immediate_respawn_is_enabled no_free_deaths.tmp matches 1 run return 0
execute if score .drop_full_xp no_free_deaths.drop_xp.settings matches 1.. run return run function no_free_deaths:mechanic/drop_xp/internal/full_drop/drop
function no_free_deaths:mechanic/drop_xp/internal/vanilla_drop/drop
