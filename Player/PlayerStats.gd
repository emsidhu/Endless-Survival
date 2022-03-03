extends Node

var attacks = {
	"BasicShot": {"name": "basicShot","text": "Basic Shot", 
"level": 1, "max_level": 6, "damage": 50, "type": "Attack"},
 
	"Vortex": {"name": "vortex","text": "Vortex", 
"level": 0, "max_level": 6, "type": "Attack"}, 

	"Lightning": {"name": "lightning","text": "Lightning", 
"level": 0, "max_level": 6, "type": "Attack"},

	"Orbit": {"name": "orbit", "text": "Orbit", 
"level": 0, "max_level": 6, "type": "Attack"}
}

var stats = {
	"Speed": {"name": "speed", "text": "Speed", 
"level": 0, "max_level": 6, "amount": 0, "upgrade_amount": 0.3, "type": "Stat"},
	"Defense": {"name": "defense", "text": "Defense", 
"level": 0, "max_level": 6, "amount": 0, "upgrade_amount": 0.3, "type": "Stat"},
	"MaxHealth": {"name": "maxhealth", "text": "Max Health", 
"level": 0, "max_level": 6, "amount": 0, "upgrade_amount": 0.5, "type": "Stat"}
}

var skills = {
	"Regen": {"name": "regenHealth", "text": "Regenerate Health", 
"level": 0, "max_level": 6, "amount": 0, "upgrade_amount": 1, "type": "Skill"},
	"Ghost": {"name": "ghost", "text": "Ghost", 
"level": 0, "max_level": 6, "type": "Skill"},
	"Test": {"name": "test", "text": "An Upgrade", 
"level": 0, "max_level": 6, "amount": 0, "upgrade_amount": 1, "type": "Skill"},
}

export var damage = 50
export(int) var max_health = 2000 setget set_max_health
var health = max_health setget set_health
var base_damage = damage
var xp = 0 setget set_xp
var max_xp = 1000 setget set_max_xp
var speedModifier = 1


signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal xp_changed(value)
signal max_xp_changed(value)
signal level_up
signal upgradeAttack


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
	
func level_up():
	emit_signal("level_up")
	self.xp = 0
	self.max_xp *= 1.15

func upgradeAttack(attack):

	attacks[attack].level += 1
	emit_signal("upgradeAttack", attacks[attack])

func upgradeStat(stat):
	stats[stat].level += 1
	stats[stat].amount += stats[stat].upgrade_amount
	
func upgradeSkill(skill):

	skills[skill].level += 1
	skills[skill].amount += skills[skill].upgrade_amount
	


func _on_RegenTimer_timeout():
	self.health += skills.Regen.amount
