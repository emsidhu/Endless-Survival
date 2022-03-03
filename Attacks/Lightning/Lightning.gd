extends Sprite

var knockback_power = 0
export var damage = 500
onready var animationPlayer = $AnimationPlayer

func ready():
	animationPlayer.playback_speed = 4
	animationPlayer.play(str(randi() % 5 + 1))
	
	damage *= (1 + (0.2 * (PlayerStats.attacks.Lightning.level - 1)))






func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
