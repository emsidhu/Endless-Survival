extends Line2D

onready var animationPlayer : AnimationPlayer = $AnimationPlayer
var divider = 5
var points_lerp = []
var sway
var sway_divider = 50

func set_start(at_position):
	add_point(at_position)

func set_end(at_position):
	add_point(at_position)
	
func segmentize(from_to, start_pos):
	points_lerp.clear()
	var distance = from_to.length()
	sway = distance/sway_divider
	sway = clamp(sway, 0, 3)
	var segment_count = distance/divider
	for point in range(0,segment_count):
		points_lerp.append(randf())
	points_lerp.sort()
	var point_index = 1
	for point_offset in points_lerp:
		add_point(start_pos + point_offset * from_to, point_index)
		point_index += 1

func sway(normal):
	var point_count = get_point_count() - 1
	for point in point_count:

		if point == 0 or point == point_count: 
			continue
		else:
			var offset = ((get_point_position(point) + get_point_position(point - 1))/2) + normal * rand_range(-sway, sway)
			set_point_position(point, offset)
	
		
