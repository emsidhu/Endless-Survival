extends Node

var enemies setget , get_enemies
var damageModifier = 1
var healthModifier = 1
var enemySpawnTime = 1
var enemySpawnAmount = 1

func _process(delta):
	damageModifier = 1 
	healthModifier = 1 
	enemySpawnAmount = 1
	enemySpawnTime
	damageModifier += (0.005 * Globals.time)
	healthModifier += (0.005 * Globals.time)
	enemySpawnAmount += (0.04 * Globals.time)
	while enemySpawnAmount > 5:
		enemySpawnTime /= 5
		enemySpawnAmount /= 5
	

func get_closest_enemy_pos(global_position):

	var closest_enemy = self.enemies[0]
	
	for enemy in enemies:
		if enemy.global_position.distance_to(global_position) < closest_enemy.global_position.distance_to(global_position):
			closest_enemy = enemy
	
	return closest_enemy.position

func get_enemies():
	enemies = get_tree().get_nodes_in_group("Enemies")
	return enemies
