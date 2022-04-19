extends Node

const XPOrb = preload("res://Pickups/XP Orb.tscn")
const ExtraXPOrb = preload("res://Pickups/XP Orb+.tscn")
const ExtraExtraXPOrb = preload("res://Pickups/XP Orb++.tscn")



func get_pickup():
	var orb = rand_range(0, 100)
	if orb < 70:
		orb = XPOrb
	elif orb < 95:
		orb = ExtraXPOrb
	else:
		orb = ExtraExtraXPOrb
	
	#returns one pickup out of the pickup_list
	return orb.instance()
