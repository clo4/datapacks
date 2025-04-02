schedule function afk_sit:check_gravity 20t

# Player hitboxes are exactly 0.6 blocks wide, so check each corner just below
# butt-level to see if it intersects with a block. If all of them are air, the
# player is unsupported and would fall.
execute as @a[tag=afk_sit.is_sitting] at @s if block ~0.3 ~0.2 ~0.3 air if block ~0.3 ~0.2 ~-0.3 air if block ~-0.3 ~0.2 ~-0.3 air if block ~-0.3 ~0.2 ~0.3 air run function afk_sit:unsit
