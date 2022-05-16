extends Area2D


export var health = 500


func _on_Timer_timeout():
	$AnimatedSprite.playing = true


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false

func _on_area_entered(area):
	if (area.get_parent().is_in_group("Player")):
		PlayerStats.health += health
		queue_free()
