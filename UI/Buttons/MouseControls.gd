extends CheckBox


func _on_MouseControls_toggled(button_pressed):
	Globals.mouseControls = button_pressed
	if Globals.mouseControls:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
