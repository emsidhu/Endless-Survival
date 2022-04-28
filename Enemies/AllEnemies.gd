extends Node

const Fuzzy = preload("res://Enemies/Fuzzy.tscn")
const Eye = preload("res://Enemies/Eye.tscn")
const Slime = preload("res://Enemies/Slime.tscn")

#List of possible enemies to spawn
var enemy_list = [Fuzzy, Eye, Eye, Eye, Slime, Slime]

func get_enemy():
	#returns one enemy out of enemy_list
	return enemy_list[randi() % enemy_list.size()].instance()
