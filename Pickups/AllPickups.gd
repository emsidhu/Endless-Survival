extends Node

const XPOrb = preload("res://Pickups/XP Orb.tscn")

#List of possible pickups to spawn
var pickup_list = [XPOrb]

func get_pickup():
	#returns one pickup out of the pickup_list
	return pickup_list[randi() % pickup_list.size()].instance()
