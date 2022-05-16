extends Area2D

export var xp = 1000
export var health = 1000
export var damage = 1000
onready var potionList = [
	preload("res://Pickups/Life Potion.tscn"),
	preload("res://Pickups/Attack Potion.tscn")
]

func _on_Random_Potion_area_entered(area):
	if (area.get_parent().is_in_group("Player")):
		var choice = randi() % 3
		if choice == 0:
			PlayerStats.xp += xp
		if choice == 1:
			PlayerStats.health += health
		else:
			for key in PlayerStats.attacks:
				PlayerStats.attacks[key].stats.damage *= 1.1
		queue_free()

