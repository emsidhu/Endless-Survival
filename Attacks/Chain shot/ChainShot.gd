extends Line2D

onready var audioStreamPlayer = $AudioStreamPlayer
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var hitbox = $Hitbox
var divider = 5
var points_lerp = []
var sway
var sway_divider = 50
var segments = []


var damage
var knockback_power


func _ready():
	damage = PlayerStats.attacks.ChainShot.stats.damage
	knockback_power = PlayerStats.attacks.ChainShot.stats.knockback_power
	hitbox.connect("hit_enemy", get_parent(), "hit_enemy")

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
	update_collision_shape()
	
func update_collision_shape():
	var n = points.size()

	# replace all segments (for now, TODO: optimize the update)
	segments.clear()
	segments.append(create_segment(points[n-2], points[n-1]))

	# re-add all segments: delete old childs and recreate all
	clear_all_shape(true)
	for segment in segments:
			hitbox.call_deferred("add_child", segment)

func clear_all_shape(keep_segments = false):
	for c in hitbox.get_children():
		c.queue_free()
	if not keep_segments:
		segments.clear()

func create_segment(p1 : Vector2, p2 : Vector2, shorten : int = 0) -> CollisionShape2D:
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = p1
	collision.shape.b = p2

	return collision



