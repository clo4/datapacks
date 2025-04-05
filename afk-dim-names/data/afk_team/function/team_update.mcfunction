# This function will continue to schedule itself indefinitely until there are
# no players with the `afk` tag any more. The schedule will be cleared from
# the "back" function.
schedule function afk_team:team_update 5s replace

team empty afk
team join afk @a[tag=afk,team=]
