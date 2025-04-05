execute store result score .difficulty no_free_deaths.tmp run difficulty
execute if score .difficulty no_free_deaths.tmp matches ..1 run scoreboard players set .drop_percentage nfd_drop_xp.settings 50
execute if score .difficulty no_free_deaths.tmp matches 2 run scoreboard players set .drop_percentage nfd_drop_xp.settings 75
execute if score .difficulty no_free_deaths.tmp matches 3.. run scoreboard players set .drop_percentage nfd_drop_xp.settings 100
scoreboard players reset .difficulty no_free_deaths.tmp
