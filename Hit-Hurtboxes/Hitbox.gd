extends Area2D

func _on_Hitbox_area_entered(area):
	if get_parent().is_in_group("Attacks"):
		area.get_parent().hit(get_parent())
