summon minecraft:experience_orb ~ ~ ~ {Value:7,Motion:[-0.046d,0.186d,-0.069d]}
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= .7 nfd_drop_xp.const
execute if score @s nfd_drop_xp.xp_orb_values matches 7.. run function nfd_drop_xp:internal/summon_orb/7/a
