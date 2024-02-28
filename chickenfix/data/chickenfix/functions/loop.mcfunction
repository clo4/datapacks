# This function runs on a slower loop of 60s because there's no need to check NBT data for the age
# on every single tick. Instead, it can be checked less regularly, and the scoreboard value can be naively
# incremented every tick. Chickens take 20 minutes to grow up, so there's no risk of missing a chicken.
#
# Only chickens that are within five blocks of a chickenfix are tracked by the scoreboard, because
# there may be a lot of chickens in the world (such as in large multiplayer servers), and most of them likely
# don't need to be tracked.

execute as @e[type=minecraft:chicken] at @s if entity @e[name="chickenfix",distance=..5] store result score @s chickenfix.chicken_age run data get entity @s Age
schedule function chickenfix:loop 60s
