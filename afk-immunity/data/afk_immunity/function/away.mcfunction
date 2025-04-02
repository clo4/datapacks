# So long as the tag has not been removed from the player, this function is idempotent.
execute if entity @s[tag=!afk_immunity.is_immune] run function afk_immunity:modify_player
