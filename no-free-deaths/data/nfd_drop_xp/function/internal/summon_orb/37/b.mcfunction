summon minecraft:experience_orb ~ ~ ~ {Value:37,Motion:[0.022d,0.173d,-0.091d]}
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= .37 nfd_drop_xp.const
execute if score @s nfd_drop_xp.xp_orb_values matches 37.. run function nfd_drop_xp:internal/summon_orb/37/a
