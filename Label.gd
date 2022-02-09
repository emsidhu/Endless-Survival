extends Label


var time = 0.0

func _process(delta):
	time += delta
	text = format_time()

	
func format_time():
	var minutes = time / 60
	var seconds = fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
	
	
