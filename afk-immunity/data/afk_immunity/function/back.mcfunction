effect clear @s resistance

clear @s minecraft:black_stained_glass_pane[custom_data~{slot_filler: true}]

item modify entity @s armor.head afk_immunity:remove_unbreakable
item modify entity @s armor.chest afk_immunity:remove_unbreakable
item modify entity @s armor.legs afk_immunity:remove_unbreakable
item modify entity @s armor.feet afk_immunity:remove_unbreakable

item modify entity @s armor.head afk_immunity:remove_binding_curse
item modify entity @s armor.chest afk_immunity:remove_binding_curse
item modify entity @s armor.legs afk_immunity:remove_binding_curse
item modify entity @s armor.feet afk_immunity:remove_binding_curse

attribute @s jump_strength modifier remove afk_immunity:no_jump
attribute @s entity_interaction_range modifier remove afk_immunity:no_interaction
attribute @s movement_speed modifier remove afk_immunity:no_movement
attribute @s oxygen_bonus modifier remove afk_immunity:no_drowning
attribute @s knockback_resistance modifier remove afk_immunity:no_knockback

tag @s remove afk_immunity.is_immune
