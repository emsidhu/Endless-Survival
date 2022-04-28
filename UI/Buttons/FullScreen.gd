extends CheckBox

func _on_FullScreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
