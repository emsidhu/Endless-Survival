extends Position2D

var status
var knockback_power = PlayerStats.attacks.Flame.stats.knockback_power
var damage = PlayerStats.attacks.Flame.stats.damage


func _on_Timer_timeout():
	get_parent().flameTimer.start(PlayerStats.attacks.Flame.stats.cooldown)
	queue_free()

func _physics_process(_delta):
	setRotation()

func _ready():
	$AudioStreamPlayer.play()
	setRotation()
	if PlayerStats.attacks.Flame.isTripled:
		$Flame2.visible = true
		$Flame3.visible = true
		$Hitbox/CollisionShape2D3.disabled = false
		$Hitbox/CollisionShape2D4.disabled = false
	if PlayerStats.attacks.Flame.stats.burn:
		status = "burn"
func setRotation():
	rotation = 0
	if Globals.mouseControls:
		look_at(get_global_mouse_position())
	else:
		rotate(Globals.player.velocity.angle())
