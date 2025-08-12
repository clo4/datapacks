say checking
execute if score .time slow_day.data matches 0..99 run scoreboard players operation .extended_daytime slow_day.data = .sunrise_ticks slow_day.settings
execute if score .time slow_day.data matches 3000..3099 run scoreboard players operation .extended_daytime slow_day.data = .mid_morning_ticks slow_day.settings
execute if score .time slow_day.data matches 6000..6099 run scoreboard players operation .extended_daytime slow_day.data = .noon_ticks slow_day.settings
execute if score .time slow_day.data matches 9000..9099 run scoreboard players operation .extended_daytime slow_day.data = .mid_afternoon_ticks slow_day.settings
execute if score .time slow_day.data matches 12000..12099 run scoreboard players operation .extended_daytime slow_day.data = .sunset_ticks slow_day.settings
