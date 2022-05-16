extends Area2D




func _on_area_entered(area):
	if (area.get_parent().is_in_group("Player")):
		PlayerStats.damageUp = true
		$Timer.start(5)


func _on_Timer_timeout():
	PlayerStats.damageUp = false
