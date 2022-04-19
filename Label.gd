extends Label




func _process(_delta):
	text = format_time()

	
func format_time():
	var minutes = Globals.time / 60
	var seconds = fmod(Globals.time, 60)
	return "%02d:%02d" % [minutes, seconds]
	
	
