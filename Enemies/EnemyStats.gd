extends Node

var enemies setget , get_enemies
var damageModifier = 1
var healthModifier = 1
var enemySpawnTime = 0.7
var enemySpawnAmount = 1
var object_position

func _process(_delta):
	damageModifier = 1 
	healthModifier = 1 
	enemySpawnAmount = 1
	damageModifier += (0.005 * Globals.time)
	healthModifier += (0.005 * Globals.time)
	enemySpawnAmount += (0.05 * Globals.time)
#	if enemySpawnAmount > 5:
#		enemySpawnTime /= 5
#		enemySpawnAmount /= 5



func sort_enemies(a, b):
	if a.global_position.distance_to(object_position) < b.global_position.distance_to(object_position):
				return true
	return false
	
func get_closest_enemy_pos(position):
	if self.enemies:
		var closest_enemy = self.enemies[0]
		
		for enemy in enemies:
			if enemy.global_position.distance_to(position) < closest_enemy.global_position.distance_to(position):
				closest_enemy = enemy
		
		return closest_enemy.global_position

func get_enemies():
	enemies = get_tree().get_nodes_in_group("Enemies")
	return enemies
