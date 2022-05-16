extends Node

const XPOrb = preload("res://Pickups/XP Orb.tscn")
const ExtraXPOrb = preload("res://Pickups/XP Orb+.tscn")
const ExtraExtraXPOrb = preload("res://Pickups/XP Orb++.tscn")
const LifePotion = preload("res://Pickups/Life Potion.tscn")



func get_pickup():
	var choice = rand_range(0, 100)
	if choice < 50:
		choice = XPOrb
	elif choice < 75:
		choice = LifePotion
	elif choice < 90:
		choice = ExtraXPOrb
	else:
		choice = ExtraExtraXPOrb
	
	#returns one pickup out of the pickup_list
	return choice.instance()
