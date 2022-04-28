extends Node2D

var amount = PlayerStats.attacks.Orbit.stats.amount setget set_amount
onready var orbs = $Orbs
var ORB = preload("res://Attacks/Orbit/Orb.tscn")


func _process(_delta):
	if (Globals.player):
		global_position = Globals.player.global_position
	
func set_amount(value):
	amount = value
	
	for child in orbs.get_children():
		orbs.remove_child(child)
		child.queue_free()
		
	var i = 0
	while i < amount:
		var orb = ORB.instance()
		var angle = 2 * PI / amount
		orb.rotation = angle * (i-1)
		i += 1
		add_child(orb)
