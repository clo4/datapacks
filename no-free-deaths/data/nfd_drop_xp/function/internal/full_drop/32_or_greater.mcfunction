# (((45 * (level * level)) − (1625 * level)) / 10) + 2,200

# xp_orb_values = lost_levels
scoreboard players operation @s nfd_drop_xp.xp_orb_values = @s nfd_drop_xp.lost_levels
# xp_orb_values *= xp_orb_values
scoreboard players operation @s nfd_drop_xp.xp_orb_values *= @s nfd_drop_xp.xp_orb_values
# xp_orb_values *= 45
scoreboard players operation @s nfd_drop_xp.xp_orb_values *= .45 nfd_drop_xp.const
# tmp = 1625
scoreboard players operation @s no_free_deaths.tmp = .1625 nfd_drop_xp.const
# tmp *= lost_levels
scoreboard players operation @s no_free_deaths.tmp *= @s nfd_drop_xp.lost_levels
# xp_orb_values −= tmp
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= @s no_free_deaths.tmp
# xp_orb_values /= 10
scoreboard players operation @s nfd_drop_xp.xp_orb_values /= .10 nfd_drop_xp.const
# xp_orb_values += 2220
scoreboard players operation @s nfd_drop_xp.xp_orb_values += .2220 nfd_drop_xp.const
