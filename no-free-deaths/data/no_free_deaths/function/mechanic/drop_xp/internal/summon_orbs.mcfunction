# For some reason, Mojang chose to drop 7 points per level that you lost when you died.
# That's... not a lot. Maybe a TODO, make this configurable, so you can recover more?
# It would be a *lot* of effort because you'd need to do some fun calculations to actually
# figure out the amount of "points" the player had, although since I know Keep Some Inventory 
# supports fully recovering your XP, they must have an implementation of this.
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values *= .7 no_free_deaths.drop_xp.const

# The game splits the total number of points that you lost into various sizes, greedily putting as
# much as possible into the largest sizes it can. For each size of orb here (replicating the sizes
# listed here: https://minecraft.wiki/w/Experience#Orb_sizes), the orb is spawned with a precalculated
# random motion that is supposed to look close enough to vanilla that you won't ever notice it's not
# *actually* random.
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 307.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/307/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 149.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/149/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 73.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/73/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 37.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/37/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 17.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/17/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 7.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/7/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 3.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/3/a
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 1.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/1/a
