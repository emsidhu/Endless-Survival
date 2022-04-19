extends Position2D

var knockback_power = PlayerStats.attacks.Flame.stats.knockback_power
var damage = PlayerStats.attacks.Flame.stats.damage

func _on_Timer_timeout():
	queue_free()

func _physics_process(_delta):
	setRotation()

func _ready():
	setRotation()
	
func setRotation():
	rotation = 0
	if Globals.mouseControls:
		look_at(get_global_mouse_position())
	else:
		rotate(Globals.player.velocity.angle())
