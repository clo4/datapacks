execute if entity @s[tag=afk_sit.is_sitting] run function afk_sit:unsit

execute unless entity @a[tag=afk] run schedule clear afk_sit:check_gravity
