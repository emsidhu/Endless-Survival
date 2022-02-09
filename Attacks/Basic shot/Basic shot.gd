extends KinematicBody2D

export var KNOCKBACK_POWER = 150
export var DAMAGE = 50
export var SPEED = 120
onready var mouse_pos = get_global_mouse_position()
onready var direction = position.direction_to(mouse_pos)

func _ready():
	look_at(mouse_pos)

func _physics_process(delta):
	var velocity = Vector2.ZERO
	velocity = direction * SPEED 
	velocity = move_and_slide(velocity)


func _on_Hitbox_area_entered(_area):
	queue_free()
