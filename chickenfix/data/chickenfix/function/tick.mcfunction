# This is a good (and fast!) approximation of the chicken's age -- adding 1 is much faster than checking NBT every tick.
# Chicken age can be increased by feeding them seeds, but this mechanic isn't typically used with chicken farms
execute as @e[scores={chickenfix.chicken_age=..-1}] run scoreboard players add @s chickenfix.chicken_age 1

# The chicken's *actual* age is always 1 greater than the scoreboard value. For chickens with a chicken_age of -1, their age *should* be 0, meaning they've just grown up.
# Using `align xz` ensures the chicken stays at its Y level but is aligned exactly to the horizontal center of the block.
execute as @e[scores={chickenfix.chicken_age=-1}] at @s if entity @e[name="chickenfix",distance=..5] if entity @s[nbt={Age:-1}] align xz run teleport @s ~0.5 ~ ~0.5
