# The player has had their 'afk' tag removed, so update the team again but if
# there are no 'afk' players the scheduled run can be cancelled.
function afk_team:team_update
execute unless entity @a[tag=afk] run schedule clear afk_team:team_update
