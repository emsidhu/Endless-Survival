extends "res://Attacks/Projectile.gd"


onready var mouse_pos = get_global_mouse_position()


func _ready():
	$CPUParticles2D.scale *= PlayerStats.attacks.Vortex.scale
	$Hitbox.scale *= PlayerStats.attacks.Vortex.scale
	
	if Globals.mouseControls:
		get_direction(mouse_pos)
	elif EnemyStats.enemies:
		get_direction(EnemyStats.get_closest_enemy_pos(global_position))
	else:
		queue_free()
		
	damage = PlayerStats.attacks.Vortex.stats.damage
	knockback_power = PlayerStats.attacks.Vortex.stats.knockback_power
	speed = PlayerStats.attacks.Vortex.stats.speed


