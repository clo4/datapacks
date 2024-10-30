summon minecraft:experience_orb ~ ~ ~ {Value:7,Motion:[0.0374d,0.0484d,-0.0191d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .7 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 7.. run function drop_xp:internal/summon_orbs/7/b
