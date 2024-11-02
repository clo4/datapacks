summon minecraft:experience_orb ~ ~ ~ {Value:7,Motion:[-0.046d,0.186d,-0.069d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .7 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 7.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/7/a
