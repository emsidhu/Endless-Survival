extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var softCollision = $SoftCollision
onready var animatedSprite = $AnimatedSprite
onready var directionTimer = $DirectionTimer
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

export var pointValue = 50
export var directionTime = 2.5
export var xp = 50
export var damage = 100
export var health = 100
export var minSpeed = 50
export var maxSpeed = 70
onready var MAX_SPEED = rand_range(minSpeed, maxSpeed)
export var ACCELERATION = 500
export var FRICTION = 500
export var SOFTPOWER = 1000

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var direction = Vector2.ZERO
var dirChange = 0.0
var error


onready var player = Globals.get("player")

signal died(xp)

func _ready():
	blinkAnimationPlayer.play("Stop")
	damage *= EnemyStats.damageModifier
	health *= EnemyStats.healthModifier
	error = connect("died", player, "killed_enemy")
	if is_instance_valid(player):
		direction = global_position.direction_to(player.global_position)
		look_at(player.global_position)

func _physics_process(delta):
	
	if is_instance_valid(player):
		if global_position.distance_to(player.global_position) > 220:
			queue_free()

		
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	rotation = 0
	rotate(velocity.angle())
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * SOFTPOWER
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION*delta)
	knockback = move_and_slide(knockback)

	velocity = move_and_slide(velocity)
	if health <= 0:
		die()

func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

func hit(attack):
	health -= attack.damage
	knockback = attack.global_position.direction_to(global_position) * attack.knockback_power
	hurtbox.start_invincibility(0.1)

func createDeathEffect():
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func die():
	emit_signal("died", xp, pointValue)
	createDeathEffect()
	queue_free()



func _on_DirectionTimer_timeout():
	directionTimer.start(directionTime)
	dirChange = rand_range(-PI / 3, PI / 3)

