execute if entity @s[tag=!afk_sit.is_sitting,tag=!afk_sit.ignore,predicate=afk_sit:on_ground] run function afk_sit:sit

schedule function afk_sit:check_gravity 20t
