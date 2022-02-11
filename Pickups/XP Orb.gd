extends Area2D

var xp = 800




func _physics_process(delta):
	if (Globals.player.global_position.distance_to(global_position) > 2000):
		queue_free()

func _on_XP_Orb_area_entered(area):
	if (area.get_parent().is_in_group("Player")):
		PlayerStats.xp += xp
		queue_free()

