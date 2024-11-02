scoreboard objectives remove no_free_deaths.death_count
scoreboard objectives remove no_free_deaths.settings
scoreboard objectives remove no_free_deaths.tmp

function #no_free_deaths:internal/uninstall

schedule clear no_free_deaths:internal/loop_respawn_check
