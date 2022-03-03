extends KinematicBody2D

const BASIC_SHOT = preload("res://Attacks/Basic shot/Basic shot.tscn")
const VORTEX = preload("res://Attacks/Vortex/Vortex.tscn")
const LIGHTNING = preload("res://Attacks/Lightning/Lightning.tscn")
const ORBIT = preload("res://Attacks/Orbit/Orbit.tscn")

onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var vortexTimer = $Timers/VortexTimer
onready var basicShotTimer = $Timers/ShotTimer
onready var lightningTimer = $Timers/LightningTimer
onready var orbitTimer = $Timers/OrbitTimer

export var SOFTPOWER = 700
export var ACCELERATION = 400
export var MAX_SPEED = 80
export(float) var FRICTION = 400

var error

var velocity = Vector2.ZERO

func _ready():
	#pause the timers for attacks player doesn't start with
	vortexTimer.paused = true
	lightningTimer.paused = true
	orbitTimer.paused = true

	
	
	error = PlayerStats.connect("no_health", self, "die")
	error = PlayerStats.connect("upgradeAttack", self, "can_shoot")
	
	Globals.set("player", self)

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Vector2.ZERO
	
	#take players movement inputs
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		#move player in direction of movement inputs
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		#slow player down if no movement inputs
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if softCollision.is_colliding():
			velocity += softCollision.get_push_vector() * delta * SOFTPOWER

	velocity = move_and_slide(velocity)
	


	
func attack(ATTACK):
	var attack = get(ATTACK).instance()
	#if the attack is a projectile spawn it on the player
	if attack.is_in_group("PlayerSpawn"):
		attack.position = position
	#otherwise, spawn it directly on the enemy
	else:
		attack.position = EnemyStats.get_closest_enemy_pos(global_position)
		
	get_parent().get_parent().add_child(attack)

#make player flash white when hit
func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

#make player take damage when touched by an enemy
func _on_Hurtbox_area_entered(area):
	PlayerStats.health -= area.get_parent().damage
	hurtbox.start_invincibility(0.5)
	
#give player xp when they kill an enemy
func killed_enemy(xp):
	PlayerStats.xp += xp

func die():
	error = get_tree().change_scene("res://Menus/GameOver.tscn")

#allows player to start using an attack when it's unlocked
func can_shoot(attack):
	get(attack.name + "Timer").paused = false

