execute as @s store result score @s drop_xp.lost_levels run xp query @s levels

# Players will always lose any points that they've gained when they die.
# This feels better than keeping them.
xp set @s 0 points

# Work can be skipped if there are no levels to drop, since we've already removed any
# points that the player had.
execute if score @s drop_xp.lost_levels matches 0 run return 0

# lost_levels = (player_level * percent) // 100
#
# As a special case, if the player has 1 level, they will always lose it. Mathematically
# this doesn't always make sense, but since it's the only level where you could die and
# respawn with the same number of levels, it doesn't feel right when playing.
# The player having 0 levels has already been handled.
execute if score @s drop_xp.lost_levels matches 2.. run scoreboard players operation @s drop_xp.lost_levels *= .drop_percentage drop_xp.settings
execute if score @s drop_xp.lost_levels matches 2.. run scoreboard players operation @s drop_xp.lost_levels /= .100 drop_xp.const

execute store result storage drop_xp:remove_xp_storage levels int 1 run scoreboard players get @s drop_xp.lost_levels
execute as @s run function drop_xp:internal/macro/remove_xp with storage drop_xp:remove_xp_storage

execute store result score .doImmediateRespawn_is_enabled drop_xp.tmp run gamerule doImmediateRespawn

# TODO: When doImmediateRespawn is enabled, center on the location of LastDeathLocation.pos and
# summon the orbs there.
# 2024-10-27: Attempted to make this work, but couldn't. I'll give it another go eventually.
execute if score .doImmediateRespawn_is_enabled drop_xp.tmp matches 0 run function drop_xp:internal/summon_orbs
