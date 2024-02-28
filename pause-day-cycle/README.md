# Pause Day Cycle

Lightweight Minecraft datapack to disable `doDaylightCycle` when nobody is
actively playing. It's best suited for small to medium sized 24/7 dedicated
servers where there are times nobody is playing -- otherwise, if the server is
running all the time, the day count becomes excessive very quickly.

When nobody is online or all online players are tagged as `afk` (see
[clo4/afk-datapack](https://github.com/clo4/afk-datapack)) the following
gamerules will be set to false:

- `doDaylightCycle`
- `doWeatherCycle`

`mobSpawning` isn't changed because it allows automatic farms to function with
nobody present.

You can also hook into it using the tags `pause_day_cycle:pause` and
`pause_day_cycle:resume`:

###### announce/data/pause_day_cycle/tags/functions/pause.json

```json
{ "values": "announce:pause" }
```

###### announce/data/announce/functions/pause.mcfunction

```mcfunction
say Day cycle has been paused because nobody's playing
```
