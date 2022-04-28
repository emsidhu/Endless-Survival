extends "res://Enemies/Enemy.gd"


func _physics_process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
