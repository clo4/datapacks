# +-------------------------+----------------+--------------------------------------+
# | PLAYER STATE            | CONDITION      | RESULT                               |
# +-------------------------+----------------+--------------------------------------+
# | Tagged "sprinting"      | Not sprinting  | Run player_stops_sprinting function  |
# | Tagged "sprinting"      | Is sprinting   | No action                            |
# | Not tagged "sprinting"  | Not sprinting  | No action                            |
# | Not tagged "sprinting"  | Is sprinting   | Run player_starts_sprinting function |
# +-------------------------+----------------+--------------------------------------+

execute if entity @s[tag=no_sprint.is_sprinting] run return run execute unless predicate no_sprint:is_sprinting run function no_sprint:player_stops_sprinting
execute if predicate no_sprint:is_sprinting run function no_sprint:player_starts_sprinting
