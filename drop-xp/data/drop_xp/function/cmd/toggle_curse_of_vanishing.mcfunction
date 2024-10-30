# Version 3819 (1.20.5) introduced the new /clear syntax which is required to do this
# in a way that isn't entirely too complicated. Doing nothing isn't great but having
# the check be done here means it doesn't have to be done on every death.
execute store result score .data_version drop_xp.tmp run data get entity @s DataVersion
execute unless score .data_version drop_xp.tmp matches 3819.. run say Minecraft 1.20.5+ is required to enable Curse of Vanishing
execute unless score .data_version drop_xp.tmp matches 3819.. run return 0

# This is a little goofy, but it works without having to add another scoreboard.
scoreboard players add .clear_curse_of_vanishing drop_xp.settings 1
execute if score .clear_curse_of_vanishing drop_xp.settings matches 1 run say Items with Curse of Vanishing will now vanish on death.

execute if score .clear_curse_of_vanishing drop_xp.settings matches 2 run scoreboard players set .clear_curse_of_vanishing drop_xp.settings 0
execute if score .clear_curse_of_vanishing drop_xp.settings matches 0 run say Items with Curse of Vanishing will no longer vanish on death.
