extends Node2D

var damage = PlayerStats.attacks.Orbit.stats.damage
var knockback_power = PlayerStats.attacks.Orbit.stats.knockback_power



func _process(_delta):
	if (Globals.player):
		global_position = Globals.player.global_position
