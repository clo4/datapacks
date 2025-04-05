summon minecraft:experience_orb ~ ~ ~ {Value:3,Motion:[0.096d,0.169d,-0.029d]}
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= .3 nfd_drop_xp.const
execute if score @s nfd_drop_xp.xp_orb_values matches 3.. run function nfd_drop_xp:internal/summon_orb/3/a
