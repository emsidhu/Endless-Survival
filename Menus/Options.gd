extends Control

onready var audioStreamPlayer = $AudioStreamPlayer

func _ready():
	$Menu/MouseControls.grab_focus()


func _on_AudioStreamPlayer_finished():
	audioStreamPlayer.playing = false


func _on_button_down():
	audioStreamPlayer.playing = true

func input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menus/MainMenu.tscn")




func _on_MouseControls_toggled(button_pressed):
	Globals.mouseControls = button_pressed



func _on_FullScreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
