summon minecraft:experience_orb ~ ~ ~ {Value:1,Motion:[-0.091d,0.118d,0.026d]}
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= .1 nfd_drop_xp.const
execute if score @s nfd_drop_xp.xp_orb_values matches 1.. run function nfd_drop_xp:internal/summon_orb/1/a
