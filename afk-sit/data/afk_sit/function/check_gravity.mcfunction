# Scheduling has to happen before unsit, because if the player gets un-sat and
# there are no more players sitting, the schedule will be cleared.
schedule function afk_sit:check_gravity 20t

# This also accidentally handles players that dismount their seats. If they
# stand on the ground, it's very likely that the block at ~0.2 is air, and
# if it is, that's functionally the same as having the block beneath the player
# removed. There are cases where this isn't true, though: tall grass, being
# inside a fence gate, etc. Those edge cases are handled by the 'back' function
# being triggered by returning, since the player still has the is_sitting tag.
# If this logic were to be changed, it's important to make sure this case is
# handled.
execute as @a[tag=afk_sit.is_sitting] at @s if block ~ ~0.2 ~ air run function afk_sit:unsit
