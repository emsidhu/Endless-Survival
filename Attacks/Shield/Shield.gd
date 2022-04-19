extends Sprite

var charges = 0 setget setCharges
var maxCharges = PlayerStats.attacks.Shield.stats.maxCharges setget setMaxCharges
onready var rechargeTimer = $RechargeTimer

func _physics_process(delta):
	if charges < maxCharges and rechargeTimer.is_stopped():
		rechargeTimer.start(PlayerStats.attacks.Shield.stats.rechargeTime)
		
	elif charges >= maxCharges:
		rechargeTimer.stop()

func _on_RechargeTimer_timeout():
	self.charges += 1

func setCharges(value):
	charges = value
	visible = true
	if charges == 3:
		modulate = Color(0, 1.16, 1.16)
	elif charges == 2:
		modulate = Color(3, .3, 0)
	elif charges == 1:
		modulate = Color(3, 0, 0)
	elif charges == 0:
		visible = false

	charges = clamp(charges, 0, maxCharges)

func setMaxCharges(value):
	maxCharges = value
	self.charges = value
