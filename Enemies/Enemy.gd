extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var softCollision = $SoftCollision
onready var animatedSprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var MAX_SPEED = rand_range(minSpeed, maxSpeed)
onready var initialModulate = animatedSprite.modulate

export var pointValue = 50
export var directionTime = 2.5
export var xp = 50
export var damage = 100
export var health = 100
export var minSpeed = 50
export var maxSpeed = 70

export var ACCELERATION = 500
export var FRICTION = 500
export var SOFTPOWER = 1000
export var turnSpeed = 0.03




var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var direction = Vector2.ZERO
var dirChange = 0.0
var error
var effect
var status = "" setget set_status
var burnRef = funcref(self, "burn")
var poisonRef = funcref(self, "poison")


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
		direction = lerp(direction, global_position.direction_to(player.global_position), turnSpeed)
		direction = direction.normalized()

	rotation = 0
	if (velocity != Vector2.ZERO):
		rotate(velocity.angle())
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * SOFTPOWER
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION*delta)
	knockback = move_and_slide(knockback)

	velocity = move_and_slide(velocity)
	if health <= 0:
		die()
	
	if status:
		get(status + "Ref").call_func()

func _on_Hurtbox_invincibility_started():
	
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

func hit(attack):
	health -= attack.damage
	knockback = attack.global_position.direction_to(global_position) * attack.knockback_power
	if attack.get("status"):
		self.status = attack.status
	

	
	hurtbox.start_invincibility(0.1)

func createDeathEffect():
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func die():
	emit_signal("died", xp, pointValue)
	createDeathEffect()
	queue_free()


func set_status(value):
	status = value
	if status != null:
		animatedSprite.modulate = Globals.get(value.to_upper() + "MODULATE")
		if effect and is_instance_valid(effect):
			effect.free()
		effect = Globals.get(value.to_upper()).instance()
		add_child(effect)
		effect.global_position = global_position
	else:
		animatedSprite.modulate = initialModulate
		if is_instance_valid(effect):
			effect.queue_free()
	
	var statusTimer = Timer.new()
	statusTimer.connect("timeout",self,"_on_statusTimer_timeout") 
	add_child(statusTimer) 
	statusTimer.start(5) 
	
func burn():
	health -= Globals.burnDamage

func poison():
	health -= Globals.poisonDamage

func _on_statusTimer_timeout():
	self.status = null
