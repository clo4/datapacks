# This is a little goofy, but it works without having to add another scoreboard.
scoreboard players add .clear_curse_of_vanishing drop_xp.settings 1
execute if score .clear_curse_of_vanishing drop_xp.settings matches 1 run say Items with Curse of Vanishing will now vanish on death.

execute if score .clear_curse_of_vanishing drop_xp.settings matches 2 run scoreboard players set .clear_curse_of_vanishing drop_xp.settings 0
execute if score .clear_curse_of_vanishing drop_xp.settings matches 0 run say Items with Curse of Vanishing will no longer vanish on death.
