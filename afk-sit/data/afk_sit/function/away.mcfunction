# So long as the tag has not been removed from the player, this function is idempotent.
execute if entity @s[tag=!afk_sit.is_sitting,predicate=afk_sit:on_ground] run function afk_sit:sit
