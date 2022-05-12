extends "res://Enemies/Enemy.gd"

	
func _physics_process(delta):
	if $AnimatedSprite.frame == 1:
		velocity = direction * MAX_SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 100 * delta)
