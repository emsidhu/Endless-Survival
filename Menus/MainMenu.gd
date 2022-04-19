extends Control

onready var audioStreamPlayer = $AudioStreamPlayer

func _ready():
	get_tree().paused = false
	PlayerStats.damage = 50
	PlayerStats.max_health = 1000
	PlayerStats.health = PlayerStats.max_health
	PlayerStats.xp = 0
	PlayerStats.max_xp = 1000
	$Menu/PlayBtn.grab_focus()


func _on_AudioStreamPlayer_finished():
	audioStreamPlayer.playing = false


func _on_button_down():
	audioStreamPlayer.playing = true
