execute unless entity @s[tag=no_free_deaths.ignore] run title @s actionbar "You have been opted out of the consequences of death."
execute if entity @s run tag @s add no_free_deaths.ignore
