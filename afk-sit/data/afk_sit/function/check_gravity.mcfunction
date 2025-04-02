schedule function afk_sit:check_gravity 20t

execute as @a[tag=afk_sit.is_sitting] at @s if block ~ ~0.2 ~ air run function afk_sit:unsit
