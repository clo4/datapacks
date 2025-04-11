# If there's no block directly under the player, kick them into standing mode
# but don't kick them out of being AFK.
# Before 1.21, the #minecraft:air tag did not exist.
execute at @s if block ~ ~0.2 ~ #afk_sit:air run return run function afk_sit:unsit

execute unless predicate afk_sit:has_seat run function afk_sit:unsit
