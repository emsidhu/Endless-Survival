extends Sprite

var knockback_power = PlayerStats.attacks.Lightning.stats.knockback_power
var damage = PlayerStats.attacks.Lightning.stats.damage
onready var animationPlayer = $AnimationPlayer
var animation = str(randi() % 2)

func ready():
	if animation == 0:
		animationPlayer.play("0")
	else:
		animationPlayer.play("1")


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
