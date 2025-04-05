summon minecraft:experience_orb ~ ~ ~ {Value:617,Motion:[0.710d,0.02d,-0.814d]}
scoreboard players operation @s nfd_drop_xp.xp_orb_values -= .617 nfd_drop_xp.const
execute if score @s nfd_drop_xp.xp_orb_values matches 617.. run function nfd_drop_xp:internal/summon_orb/617/b
