summon minecraft:experience_orb ~ ~ ~ {Value:1,Motion:[0.134d,0.218d,-0.126d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .1 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 1.. run function drop_xp:internal/summon_orbs/1/a
