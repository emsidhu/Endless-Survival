extends Control

onready var audioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	$Title.text = "Your Score Was " + str(Globals.score)
	$Menu/ChangeSceneBtn.grab_focus()


func _on_ChangeSceneBtn_button_up():
	PlayerStats.resetStats()


func _on_AudioStreamPlayer_finished():
	audioStreamPlayer.playing = false


func _on_button_down():
	audioStreamPlayer.playing = true
