extends KinematicBody2D

const BASIC_SHOT = preload("res://Attacks/Basic shot/Basic shot.tscn")
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision

export var SOFTPOWER = 700
export var ACCELERATION = 400
export var MAX_SPEED = 80
export(float) var FRICTION = 400

var velocity = Vector2.ZERO

func _ready():
	PlayerStats.connect("no_health", self, "queue_free")
	Globals.set("player", self)

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if softCollision.is_colliding():
			velocity += softCollision.get_push_vector() * delta * SOFTPOWER

	velocity = move_and_slide(velocity)
	

func basic_shot():
	var basic_shot = BASIC_SHOT.instance()
	basic_shot.position = position

	get_parent().add_child(basic_shot)
	


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")


func _on_Hurtbox_area_entered(area):
	PlayerStats.health -= area.get_parent().damage
	hurtbox.start_invincibility(0.5)
	
func killed_enemy(xp):
	PlayerStats.xp += xp
