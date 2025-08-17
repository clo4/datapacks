# Longer Day

Longer Day slows down the day cycle by extending the day at specific points,
rather than simply making the sun move slower. This approach is similar to Mario
Kart World, where the day cycle takes a set number of minutes but pauses at
particularly scenic moments.

By default, the day cycle pauses at the following times:

| Time          | longer_days.settings | Duration  | Ticks |
| ------------- | -------------------- | --------- | ----- |
| Sunrise       | `.sunrise`           | 1 minute  | 1200  |
| Mid morning   | `.morning`           | 2 minutes | 2400  |
| Midday (noon) | `.midday`            | 1 minute  | 1200  |
| Mid afternoon | `.afternoon`         | 2 minutes | 2400  |
| Sunset        | `.sunset`            | 1 minute  | 1200  |

There are also three times that don't extend the day by default but can be set
with a duration to extend.

| Time               | longer_days.settings |
| ------------------ | -------------------- |
| Twilight (evening) | `.twilight_evening`  |
| Midnight           | `.midnight`          |
| Twilight (morning) | `.twilight_morning`  |

Toggling day cycle state (paused -> unpaused, unpaused -> paused) works as
expected. However, if the day cycle is disabled by this data pack, attempting to
set the day cycle to false will do nothing as it is already disabled.

This data pack is compatible with Pause Day Cycle. When the day cycle is paused
(no players online or all are AFK) this data pack will stop checking, and resume
when there is an active player.

## Customization

This data pack is designed from the ground up to be easy to extend and tweak.
You can adjust the duration of each pause, or even entirely change when the
pauses occur.

### Adjusting Default Durations

If you don't like the default pause durations, change them using these commands,
replacing `TICKS` with the number of ticks to extend the day by. 1 minute is
1200 ticks, so to extend the day by 3 minutes at noon, you would use `3600`.

```mcfunction
/scoreboard players set .sunrise longer_days.settings TICKS
/scoreboard players set .morning longer_days.settings TICKS

/scoreboard players set .noon longer_days.settings TICKS

/scoreboard players set .afternoon longer_days.settings TICKS
/scoreboard players set .sunset longer_days.settings TICKS

/scoreboard players set .twilight_evening longer_days.settings TICKS
/scoreboard players set .midnight longer_days.settings TICKS
/scoreboard players set .twilight_morning longer_days.settings TICKS
```

### Custom Pause Times

To change when the day pauses, create a simple data pack to override the
`longer_days:check` function:

**`YOUR_DATA_PACK_NAME/data/longer_days/function/check.mcfunction`**

This function will be called to check whether time should pause. Set the
`.extended_daytime` value in the `longer_days.data` scoreboard to the number of
ticks before the day cycle resumes. Since this function runs every 100 ticks,
check for time ranges rather than exact values:

```mcfunction
execute store result score .time longer_days.data run time query daytime
execute if score .time longer_days.data matches 0..99 run scoreboard players set .extended_daytime longer_days.data 2400
execute if score .time longer_days.data matches 6000..6099 run scoreboard players set .extended_daytime longer_days.data 3600
execute if score .time longer_days.data matches 12000..12099 run scoreboard players set .extended_daytime longer_days.data 2400
```

Since the check runs every 100 ticks, use multiples of 100 for the extended
daytime value (each 100 ticks = 5 seconds).

You can see how the default logic works in this file:
[check.mcfunction](./data/longer_days/function/check.mcfunction)

To make sure your override is loaded, it needs be loaded "after" the longer-days
data pack. You can do this by manually ordering the data packs when creating the
world, naming your custom data pack starting with a letter after "L", or
disabling then enabling it.

## Compatibility

This data pack is not ported to older versions due to a visual glitch that was
fixed in the 1.21 cycle. In earlier versions, the sun and moon would continue
moving briefly after the `doDaylightCycle` gamerule changed. This is a minor
glitch for vanilla players, but extremely noticeable for shader users because
shadows change instantly.
