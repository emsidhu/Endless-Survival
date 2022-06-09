extends Node

var enemies setget , get_enemies
var damageModifier = 1
var healthModifier = 1
var enemySpawnTime = 0.7
var enemySpawnAmount = 1
var object_position

func _process(_delta):



	damageModifier = (0.01 * Globals.time) + 1
	healthModifier = (0.01 * Globals.time) + 1
	enemySpawnAmount = 20 * atan((Globals.time/60) - 0.05) + 2
#	if enemySpawnAmount > 5:
#		enemySpawnTime /= 5
#		enemySpawnAmount /= 5



func sort_enemies(a, b):
	if a.global_position.distance_to(object_position) < b.global_position.distance_to(object_position):
				return true
	return false
	
func get_closest_enemy_pos(position, exceptions = []):
	if self.enemies:
		var closest_enemy = self.enemies[0].get_child(0)
		
		for enemyC in enemies:
			var enemy = enemyC.get_child(0)
			var is_exception = false
	
			if enemy.global_position.distance_to(position) < closest_enemy.global_position.distance_to(position):
				for exception in exceptions:
					if enemy.get_parent() == exception:
						is_exception = true
						break
				if !is_exception:
					closest_enemy = enemy
		for exception in exceptions:
			if closest_enemy == exception:
				return false
		return closest_enemy.global_position

func get_enemies():
	enemies = get_tree().get_nodes_in_group("Enemies")
	return enemies
