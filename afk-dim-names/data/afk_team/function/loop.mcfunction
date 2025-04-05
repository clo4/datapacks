# Every 5 seconds, we'll empty the 'afk' team and re-add everyone that's
# currently AFK and teamless to it. This mostly resolves the issue of players
# joining the game after leaving while AFK still having a grey name and prefix.
# Initially I built a system to detect whether a player joined or left, but that
# resulted in the server doing more work than simply emptying a team and
# re-adding players to it.

schedule function afk_team:loop 5s

team empty afk
team join afk @a[tag=afk,team=]
