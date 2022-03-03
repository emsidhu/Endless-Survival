extends "res://Attacks/Projectile.gd"


func _ready():
	damage *= (1 + (0.2 * (PlayerStats.attacks.BasicShot.level - 1)))
	if EnemyStats.enemies:
		get_direction(EnemyStats.get_closest_enemy_pos(global_position))
	else:
		queue_free()
	
func _on_Hitbox_area_entered(_area):
	queue_free()

