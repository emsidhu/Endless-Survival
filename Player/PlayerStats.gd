extends Node


export var damage = 50
export(int) var max_health = 1000 setget set_max_health
var health = max_health setget set_health
var base_damage = damage
var xp = 0 setget set_xp
var max_xp = 1000 setget set_max_xp


signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal xp_changed(value)
signal max_xp_changed(value)
signal level_up

func _ready():
	base_damage = damage
	self.health = max_health

func set_max_health(value):
	max_health = max(value, 1)
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_xp(value):
	xp = value
	emit_signal("xp_changed", xp)
	if xp >= max_xp:
		level_up()

func set_max_xp(value):
	max_xp = value
	emit_signal("max_xp_changed", max_xp)
	print(max_xp)
	
func level_up():
	emit_signal("level_up")
	self.xp = 0
	self.max_xp *= 1.5
