extends KinematicBody2D

onready var softCollision = $SoftCollision
onready var animatedSprite = $AnimatedSprite

export var xp = 500
export var damage = 100
export var health = 100
export var MAX_SPEED = 20.0
export var ACCELERATION = 500
export var FRICTION = 500
export var SOFTPOWER = 1000
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var direction = Vector2.ZERO
onready var player = Globals.get("player")

signal died(xp)

func _ready():
	connect("died", player, "killed_enemy")

func _physics_process(delta):
	if is_instance_valid(player):
		direction = global_position.direction_to(player.global_position)
		look_at(player.global_position)
		
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * SOFTPOWER
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION*delta)
	knockback = move_and_slide(knockback)

	velocity = move_and_slide(velocity)
	
	if position.distance_to(player.position) > 1000:
		queue_free()
	
	if health <= 0:
		die()


func _on_Hurtbox_area_entered(area):
	var attack = area.get_parent()
	health -= attack.DAMAGE
	knockback = attack.global_position.direction_to(global_position) * attack.KNOCKBACK_POWER

func die():
	emit_signal("died", xp)
	queue_free()

