extends "res://Attacks/Projectile.gd"

onready var hitbox = $Hitbox


func _ready():

	damage = PlayerStats.attacks.BasicShot.stats.damage
	knockback_power = PlayerStats.attacks.BasicShot.stats.knockback_power
	speed = PlayerStats.attacks.BasicShot.stats.speed
	if EnemyStats.enemies:
		get_direction(EnemyStats.get_closest_enemy_pos(global_position))
	else:
		get_parent().queue_free()
	
func _on_Hitbox_area_entered(_area):
	get_parent().visible = false
	hitbox.set_deferred("monitoring", false)
	$HitSound.playing = true





func _on_HitSound_finished():
	get_parent().queue_free()



