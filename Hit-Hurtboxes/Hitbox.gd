extends Area2D

signal hit_enemy

func _on_Hitbox_area_entered(area):
	var enemy = area.get_parent()
	if get_parent().is_in_group("Attacks"):
		enemy.hit(get_parent())
		emit_signal("hit_enemy", enemy.global_position, enemy)
