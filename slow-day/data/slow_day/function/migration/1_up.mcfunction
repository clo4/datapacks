scoreboard players set #migration slow_day.migration 1

# This will be used to store the time rounded to the nearest 100.
# 100 is significant because with 20 ticks in a second, and a 5
# second loop, the time will always increment by 100 when we check.
scoreboard objectives add slow_day.data dummy
scoreboard objectives add slow_day.settings dummy

scoreboard players set .extended_daytime slow_day.data 0

scoreboard players set #one_minute slow_day.settings 1200
scoreboard players set #two_minutes slow_day.settings 2400

scoreboard players operation .sunrise_ticks slow_day.settings = #one_minute slow_day.settings
scoreboard players operation .sunset_ticks slow_day.settings = #one_minute slow_day.settings

scoreboard players operation .mid_morning_ticks slow_day.settings = #two_minutes slow_day.settings
scoreboard players operation .noon_ticks slow_day.settings = #two_minutes slow_day.settings
scoreboard players operation .mid_afternoon_ticks slow_day.settings = #two_minutes slow_day.settings
