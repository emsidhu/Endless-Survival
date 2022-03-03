extends "res://Enemies/Enemy.gd"

func _physics_process(_delta):
	if is_instance_valid(player):
		direction = lerp(direction, global_position.direction_to(player.global_position), 0.0008)
	direction = direction.normalized()
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
