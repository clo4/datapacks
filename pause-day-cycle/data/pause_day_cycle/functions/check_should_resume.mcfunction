# If there's at least one player online that doesn't have the afk tag, it's fine to resume
execute if entity @a[tag=!afk] run function pause_day_cycle:resume
