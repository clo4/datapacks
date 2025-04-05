# (level * level) + (6 * level)

# xp_orb_values = lost_levels
scoreboard players operation @s nfd_drop_xp.xp_orb_values = @s nfd_drop_xp.lost_levels

# xp_orb_values *= xp_orb_values
scoreboard players operation @s nfd_drop_xp.xp_orb_values *= @s nfd_drop_xp.xp_orb_values

# tmp = 6
scoreboard players operation @s no_free_deaths.tmp = .6 nfd_drop_xp.const

# tmp *= lost_levels
scoreboard players operation @s no_free_deaths.tmp *= @s nfd_drop_xp.lost_levels

# xp_orb_values += tmp
scoreboard players operation @s nfd_drop_xp.xp_orb_values += @s no_free_deaths.tmp
