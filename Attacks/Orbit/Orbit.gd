extends Node2D

export var damage = 80
export var knockback_power = 0

func _ready():
	damage *= (1 + (0.2 * (PlayerStats.attacks.Orbit.level - 1)))

func _process(delta):
	if (Globals.player):
		global_position = Globals.player.global_position
