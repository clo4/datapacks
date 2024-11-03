execute as @s store result score @s no_free_deaths.drop_xp.lost_levels run xp query @s levels

# Players will always lose any points that they've gained when they die.
# This feels better than keeping them.
xp set @s 0 points

# lost_levels = (player_level * percent) // 100
#
# As a special case, if the player has 1 level, they will always lose it. Mathematically
# this doesn't always make sense, but since it's the only level where you could die and
# respawn with the same number of levels, it doesn't feel right when playing.
# The player having 0 levels has already been handled.
execute if score @s no_free_deaths.drop_xp.lost_levels matches 2.. run scoreboard players operation @s no_free_deaths.drop_xp.lost_levels *= .drop_percentage no_free_deaths.drop_xp.settings
execute if score @s no_free_deaths.drop_xp.lost_levels matches 2.. run scoreboard players operation @s no_free_deaths.drop_xp.lost_levels /= .100 no_free_deaths.drop_xp.const

scoreboard players operation @s no_free_deaths.drop_xp.levels_to_remove = @s no_free_deaths.drop_xp.lost_levels
execute if score @s no_free_deaths.drop_xp.levels_to_remove matches 1.. as @s run function no_free_deaths:mechanic/drop_xp/internal/remove_xp

# NOTE: With doImmediateRespawn, this would be triggered *after* the player respawns, so if it is enabled,
# there isn't really a sane way to summon the XP orbs. While player do now store their last death location,
# making the XP spawn there would massively complicate the logic for something that almost nobody uses.
execute store result score .do_immediate_respawn_is_enabled no_free_deaths.tmp run gamerule doImmediateRespawn

scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values = @s no_free_deaths.drop_xp.lost_levels
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 1.. if score .do_immediate_respawn_is_enabled no_free_deaths.tmp matches 0 run function no_free_deaths:mechanic/drop_xp/internal/summon_orbs
