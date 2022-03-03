extends Node

const Fuzzy = preload("res://Enemies/Fuzzy.tscn")
const Eye = preload("res://Enemies/Eye.tscn")

#List of possible enemies to spawn
var enemy_list = [Fuzzy, Eye, Eye]

func get_enemy():
	#returns one enemy out of enemy_list
	return enemy_list[randi() % enemy_list.size()].instance()
