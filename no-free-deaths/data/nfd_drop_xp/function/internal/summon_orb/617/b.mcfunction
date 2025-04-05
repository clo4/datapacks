summon minecraft:experience_orb ~ ~ ~ {Value:617,Motion:[-0.114d,0.035d,-0.0952d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .617 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 617.. run function nfd_drop_xp:internal/summon_orb/617/a
