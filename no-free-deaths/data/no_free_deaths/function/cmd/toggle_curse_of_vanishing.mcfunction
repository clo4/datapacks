scoreboard players add .enable_curse_of_vanishing no_free_deaths.settings 1
execute if score .enable_curse_of_vanishing no_free_deaths.settings matches 1 run tellraw @a {"text": "Items with Curse of Vanishing will now vanish on death"}

execute if score .enable_curse_of_vanishing no_free_deaths.settings matches 2 run scoreboard players set .enable_curse_of_vanishing no_free_deaths.settings 0
execute if score .enable_curse_of_vanishing no_free_deaths.settings matches 0 run tellraw @a {"text": "Items with Curse of Vanishing will no longer vanish on death"}
