# This is a long command, so to summarize...
# Sit if the player is:
# - Not already sitting
# - Not ignored by this data pack
# - On the ground (not riding an entity, flying, falling, floating, etc.)
# - Not centered over air
# - Not crawling: Positioned at least one block away from themselves (centered
#   at eyes, if the player entity can also be found at least one block away
#   they must not be crawling, since the hitbox shrinks so much)
execute if entity @s[tag=!afk_sit.is_sitting,tag=!afk_sit.ignore,predicate=afk_sit:on_ground] at @s unless block ~ ~-0.1 ~ #air anchored eyes positioned ^ ^ ^ if entity @s[distance=1..] run function afk_sit:sit
