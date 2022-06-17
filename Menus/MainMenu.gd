extends Control



onready var audioStreamPlayer = $AudioStreamPlayer

func _ready():
	get_tree().paused = false
	PlayerStats._ready()
	$Menu/PlayBtn.grab_focus()
	Globals.loadScores()




func _on_AudioStreamPlayer_finished():
	audioStreamPlayer.playing = false


func _on_button_down():
	audioStreamPlayer.playing = true


