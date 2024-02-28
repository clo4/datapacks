# chickenfix

Simple (but performant) brute-force fix to chickens suffocating to death when
they grow up, such as in fox-based chicken farms.

This datapack "fixes" the problem by centering the chickens on the block when
they grow up, but only if they're within five blocks of an entity named
`chickenfix`.

## Why isn't the fix applied globally?

This solution would cause problems for normal chicken farms due to fence
hitboxes, and it's also entirely unnecessary for chickens where you don't really
care if they suffocate or not.
