scoreboard players set #migration longer_days.migration 1

# This will be used to store the time rounded to the nearest 100.
# 100 is significant because with 20 ticks in a second, and a 5
# second loop, the time will always increment by 100 when we check.
scoreboard objectives add longer_days.data dummy
scoreboard objectives add longer_days.settings dummy

scoreboard players set .extended_daytime longer_days.data 0

scoreboard players set #one_minute longer_days.settings 1200

scoreboard players operation .sunrise longer_days.settings = #one_minute longer_days.settings
scoreboard players operation .morning longer_days.settings = #one_minute longer_days.settings
scoreboard players operation .midday longer_days.settings = #one_minute longer_days.settings
scoreboard players operation .afternoon longer_days.settings = #one_minute longer_days.settings
scoreboard players operation .sunset longer_days.settings = #one_minute longer_days.settings

# These are present for players to set if they want to extend the night, but are
# never enabled by default.
scoreboard players set .midnight longer_days.settings 0
scoreboard players set .twilight_evening longer_days.settings 0
scoreboard players set .twilight_morning longer_days.settings 0
