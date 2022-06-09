extends Node

var LIGHTNING = preload("res://Attacks/Lightning/Lightning.tscn")

func _ready():
	var amount = PlayerStats.attacks.Lightning.stats.amount
	var i = 0
	EnemyStats.object_position = Globals.player.global_position
	var enemies = EnemyStats.enemies
	enemies.sort_custom(EnemyStats, "sort_enemies")
	while(i < amount):
		var lightning = LIGHTNING.instance()
		if enemies.size() > i:
			lightning.global_position = enemies[i].global_position
		get_parent().get_parent().get_parent().get_parent().add_child(lightning)
		i += 1
		print("spawnLightning")
	queue_free()
