summon minecraft:experience_orb ~ ~ ~ {Value:73,Motion:[-0.084d,0.145d,-0.090d]}
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= .73 nfd_drop_xp.const
execute if score @s nfd_drop_xp.xp_orb_values matches 73.. run function nfd_drop_xp:internal/summon_orb/73/a
