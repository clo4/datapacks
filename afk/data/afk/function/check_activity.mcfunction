# If the player is not moving then no scores need to be reset.
execute if predicate afk:player_inactive run return run function afk:player_inactive

scoreboard players set @s afk.ticks_inactive 0
