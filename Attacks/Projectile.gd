extends KinematicBody2D

export var knockback_power = 150
export var damage = 50
export var speed = 120
var direction = Vector2.ZERO

func get_direction(point):
	direction = global_position.direction_to(point)
	look_at(point)
	
func _physics_process(_delta):
	var velocity = Vector2.ZERO
	velocity = direction * speed
	velocity = move_and_slide(velocity)


