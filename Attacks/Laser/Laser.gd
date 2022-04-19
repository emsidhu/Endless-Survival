extends RayCast2D

var is_casting = false setget set_is_casting
onready var line2D = $Line2D
onready var tween = $Tween
onready var castingParticles2D = $CPUParticles2D


var knockback_power = PlayerStats.attacks.Laser.stats.knockback_power
var damage = PlayerStats.attacks.Laser.stats.damage

func _ready():
	get_parent().rotation = rand_range(0, 360)
	set_physics_process(false)
	line2D.points[1] = Vector2.ZERO
	self.is_casting = true



func _physics_process(_delta):
	var cast_point:= cast_to
	force_raycast_update()
	

	
	if is_colliding():

		get_collider().get_parent().hit(self)
	
	line2D.points[1] = cast_point

	
func set_is_casting(cast):
	is_casting = cast
	
	castingParticles2D.emitting = is_casting

	if is_casting:
		appear()
	else:
		disappear()
	set_physics_process(is_casting)
	
func appear():
	tween.stop_all()
	tween.interpolate_property($Line2D, "width", 0, 2.5, 0.1)
	tween.start()
	
func disappear():
	tween.stop_all()
	tween.interpolate_property($Line2D, "width", 2.5, 0, 0.05)
	tween.start()


func _on_StopTimer_timeout():
	self.is_casting = false
	$DieTimer.start(0.3)


func _on_DieTimer_timeout():
	get_parent().queue_free()
