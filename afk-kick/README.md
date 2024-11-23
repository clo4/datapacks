# Documentation

AFK Kick requires a function permission level of 3 (it's set to 2 by default).
To enable this in your server, change the `function-permission-level` in your
`server.properties` to 3. Copy/paste:

```ini
function-permission-level=3
```

The scoreboard tag `afk_kick.ignore` makes players exempt from being kicked.

There is a function tag `#afk_kick:player_will_be_kicked` that is executed
before any players are kicked. This allows addons to be notified of the kick
while the player is still online.
