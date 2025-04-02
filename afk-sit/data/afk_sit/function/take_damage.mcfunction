advancement revoke @s only afk_sit:take_damage
execute if entity @s[tag=afk_sit.is_sitting,tag=!afk_immunity.is_immune] run function afk_sit:unsit
