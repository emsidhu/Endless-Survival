extends "res://Attacks/Projectile.gd"


onready var mouse_pos = get_global_mouse_position()


func _ready():
	get_direction(mouse_pos)
	damage *= (1 + (0.2 * (PlayerStats.attacks.Vortex.level - 1)))

