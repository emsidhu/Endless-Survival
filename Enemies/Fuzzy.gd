extends "res://Enemies/Enemy.gd"

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _physics_process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
