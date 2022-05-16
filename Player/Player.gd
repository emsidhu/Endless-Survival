extends KinematicBody2D

const BASICSHOT = preload("res://Attacks/Basic shot/Basic shot.tscn")
const VORTEX = preload("res://Attacks/Vortex/Vortex.tscn")
const LIGHTNINGSPAWNER = preload("res://Attacks/Lightning/LightningSpawner.tscn")
const FLAME = preload("res://Attacks/Flame/Flame.tscn")
const LASERSPAWNER = preload("res://Attacks/Laser/LaserSpawner.tscn")
const CHAINSHOT = preload("res://Attacks/Chain shot/LightningGenerator.tscn")

onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var vortexTimer = $Timers/VortexTimer
onready var basicShotTimer = $Timers/ShotTimer
onready var lightningTimer = $Timers/LightningTimer
onready var flameTimer = $Timers/FlameTimer
onready var laserTimer = $Timers/LaserTimer

onready var shield = $Shield
onready var orbit = $Orbit


export var SOFTPOWER = 700
export var ACCELERATION = 700

var hasShield = false setget setShield

onready var attacks = PlayerStats.attacks
onready var stats = PlayerStats.stats

var error

var velocity = Vector2.ZERO

func _ready():
	#pause the timers for attacks player doesn't start with
	#basicShotTimer.paused = true
	lightningTimer.paused = true
	vortexTimer.paused = true
	flameTimer.paused = true
	laserTimer.paused = true
	shield.visible = false


	
	error = PlayerStats.connect("no_health", self, "die")
	error = PlayerStats.connect("upgradeAttack", self, "can_shoot")
	error = PlayerStats.connect("cooldownChange", self, "changeCooldown")
	
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
		velocity = velocity.move_toward(input_vector * stats.Speed.amount, ACCELERATION * delta)
	else:
		#slow player down if no movement inputs
		velocity = velocity.move_toward(Vector2.ZERO, stats.Speed.amount * 5 * delta)

	if softCollision.is_colliding():
			velocity += softCollision.get_push_vector() * delta * SOFTPOWER

	velocity = move_and_slide(velocity)
	
	

func followAttack(ATTACK):
	var attack = get(ATTACK).instance()
	add_child(attack)

func projectileAttack(ATTACK):
	var attack = get(ATTACK).instance()
	attack.position = position
	get_parent().get_parent().add_child(attack)

func Spawner(SPAWNER):
	var spawner = get(SPAWNER).instance()
	add_child(spawner)
	
#make player flash white when hit
func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")


#make player take damage when touched by an enemy
func _on_Hurtbox_area_entered(area):
	if hasShield and shield.charges > 0:
		shield.charges -= 1
	else:
		PlayerStats.health -= area.get_parent().damage * stats.Defense.amount
	hurtbox.start_invincibility(0.3)
	
#give player xp when they kill an enemy
func killed_enemy(xp, pointValue):
	PlayerStats.xp += xp
	Globals.score += pointValue

func die():
	if stats.Revive.canRevive:
		PlayerStats.health = PlayerStats.max_health
		stats.Revive.canRevive = false
		return
	error = get_tree().change_scene("res://Menus/GameOver.tscn")

#allows player to start using an attack when it's unlocked
func can_shoot(attack):
	if attack.name == "shield":
		self.hasShield = true
	elif attack.name == "orbit":
		orbit.amount = attacks.Orbit.stats.amount
	elif attack.name == "chainShot":
		$LightningGenerator/Timer.start(PlayerStats.attacks.ChainShot.stats.cooldown)
	else:
		get(attack.name + "Timer").paused = false

func changeCooldown(dict):
	get_node("Timers/" + dict.timer).wait_time = dict.cooldown
	
func setShield(value):
	hasShield = value
	shield.visible = value
	shield.maxCharges = attacks.Shield.stats.maxCharges



