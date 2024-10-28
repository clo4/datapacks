execute as @s store result score @s drop_xp.dropped_xp run xp query @s levels

# Work can be skipped if there are no levels to drop
execute if score @s drop_xp.dropped_xp matches 0 run return 0

# drop = (level * percent) / 100
scoreboard players operation @s drop_xp.dropped_xp *= .drop_percentage drop_xp.settings
scoreboard players operation @s drop_xp.dropped_xp /= .100 drop_xp.const

# Skip further execution if the player would not lose any levels
execute if score @s drop_xp.dropped_xp matches 0 run return 0

execute store result storage drop_xp:remove_xp_storage levels int 1 run scoreboard players get @s drop_xp.dropped_xp
execute as @s run function drop_xp:internal/macro/remove_xp with storage drop_xp:remove_xp_storage

execute store result score .doImmediateRespawn_is_enabled drop_xp.tmp run gamerule doImmediateRespawn

# TODO: When doImmediateRespawn is enabled, center on the location of LastDeathLocation.pos and
# summon the orbs there.
# 2024-10-27: Attempted to make this work, but couldn't. I'll give it another go eventually.
execute if score .doImmediateRespawn_is_enabled drop_xp.tmp matches 0 run function drop_xp:internal/summon_orbs
