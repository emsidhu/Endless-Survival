extends "res://Attacks/Projectile.gd"

onready var hitbox = $Hitbox
var enemies = EnemyStats.enemies

func _ready():
	EnemyStats.object_position = Globals.player.global_position
	enemies.sort_custom(EnemyStats, "sort_enemies")
	var shots = get_tree().get_nodes_in_group("Basic Shot").size()
	if shots > 1:
		if EnemyStats.enemies.size() >= shots:
			get_direction(enemies[shots - 1].global_position)
		else:
			queue_free()
	elif enemies.size() > 0:
		get_direction(enemies[shots - 1].global_position)
	else:
		get_parent().queue_free()
		
	damage = PlayerStats.attacks.BasicShot.stats.damage
	knockback_power = PlayerStats.attacks.BasicShot.stats.knockback_power
	speed = PlayerStats.attacks.BasicShot.stats.speed
	
func _on_Hitbox_area_entered(_area):
	get_parent().visible = false
	hitbox.set_deferred("monitoring", false)
	$HitSound.playing = true





func _on_HitSound_finished():
	get_parent().queue_free()



