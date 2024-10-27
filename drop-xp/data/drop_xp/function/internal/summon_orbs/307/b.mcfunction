summon minecraft:experience_orb ~ ~ ~ {Value:307,Motion:[0.004d,0.195d,0.089d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .307 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 307.. run function drop_xp:internal/summon_orbs/307/a
