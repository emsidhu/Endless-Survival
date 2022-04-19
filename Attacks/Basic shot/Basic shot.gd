extends "res://Attacks/Projectile.gd"


func _ready():
	damage = PlayerStats.attacks.BasicShot.stats.damage
	knockback_power = PlayerStats.attacks.BasicShot.stats.knockback_power
	speed = PlayerStats.attacks.BasicShot.stats.speed
	if EnemyStats.enemies:
		get_direction(EnemyStats.get_closest_enemy_pos(global_position))
	else:
		queue_free()
	
func _on_Hitbox_area_entered(_area):
	queue_free()

