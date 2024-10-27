summon minecraft:experience_orb ~ ~ ~ {Value:17,Motion:[0.135d,0.111d,-0.162d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .17 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 17.. run function drop_xp:internal/summon_orbs/17/a
