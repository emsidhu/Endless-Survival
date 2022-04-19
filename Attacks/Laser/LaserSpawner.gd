extends Node

var LASER = preload("res://Attacks/Laser/Laser.tscn")

func _ready():
	var amount = PlayerStats.attacks.Laser.stats.amount
	var i = 0
	while(i < amount):
		var laser = LASER.instance()
		get_parent().add_child(laser)
		i += 1
	queue_free()
