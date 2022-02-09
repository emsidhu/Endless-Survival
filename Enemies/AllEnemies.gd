extends Node

const Fuzzy = preload("res://Enemies/Fuzzy.tscn")
const Eye = preload("res://Enemies/Eye.tscn")

#List of possible enemies to spawn
var enemy_list = [Eye, Eye, Eye, Eye, Fuzzy]

func get_enemy():
	#picks one enemy out of enemy_list
	var choice = enemy_list[randi() % enemy_list.size()]
	return choice
