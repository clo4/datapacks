# As a sanity check, if the configured drop percentage is out of bounds, it will be
# brought back within the range of allowed values.
execute if score .drop_percentage drop_xp.settings matches 101.. run scoreboard players set .drop_percentage drop_xp.settings 100
execute if score .drop_percentage drop_xp.settings matches ..-1 run scoreboard players set .drop_percentage drop_xp.settings 0

execute as @s store result score @s drop_xp.lost_levels run xp query @s levels

# Work can be skipped if there are no levels to drop
execute if score @s drop_xp.lost_levels matches 0 run return 0

# drop = (level * percent) / 100
scoreboard players operation @s drop_xp.lost_levels *= .drop_percentage drop_xp.settings
scoreboard players operation @s drop_xp.lost_levels /= .100 drop_xp.const

# Skip further execution if the player would not lose any levels
execute if score @s drop_xp.lost_levels matches 0 run return 0

execute store result storage drop_xp:remove_xp_storage levels int 1 run scoreboard players get @s drop_xp.lost_levels
execute as @s run function drop_xp:internal/macro/remove_xp with storage drop_xp:remove_xp_storage

execute store result score .doImmediateRespawn_is_enabled drop_xp.tmp run gamerule doImmediateRespawn

# TODO: When doImmediateRespawn is enabled, center on the location of LastDeathLocation.pos and
# summon the orbs there.
# 2024-10-27: Attempted to make this work, but couldn't. I'll give it another go eventually.
execute if score .doImmediateRespawn_is_enabled drop_xp.tmp matches 0 run function drop_xp:internal/summon_orbs
