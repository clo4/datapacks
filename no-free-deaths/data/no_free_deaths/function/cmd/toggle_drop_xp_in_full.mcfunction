scoreboard players add .drop_full_xp nfd_drop_xp.settings 1
execute if score .drop_full_xp nfd_drop_xp.settings matches 2.. run scoreboard players set .drop_full_xp nfd_drop_xp.settings 0

execute if score .drop_full_xp nfd_drop_xp.settings matches 1 run tellraw @a {"text": "Players will now drop enough XP to fully recover their levels"}
execute if score .drop_full_xp nfd_drop_xp.settings matches 0 run tellraw @a {"text": "Players will drop the default amount of XP on death"}
