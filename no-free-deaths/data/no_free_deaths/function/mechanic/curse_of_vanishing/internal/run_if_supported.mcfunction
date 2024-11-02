execute store result score .data_version no_free_deaths.tmp run data get entity @s DataVersion
execute if score .data_version no_free_deaths.tmp matches 3819.. run function no_free_deaths:mechanic/curse_of_vanishing/internal/apply
