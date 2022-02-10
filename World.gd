extends Node2D

onready var timer = $Timer
onready var player = $YSort/Player
onready var ySort = $YSort

export var spawn_time = 1
export var spawn_amount = 1
var can_spawn = false



func _on_Timer_timeout():
	if  (is_instance_valid(player)):
		var rand_pos
		var i = 0
		var left_bound = player.position.x - get_viewport_rect().size.x / 2
		var right_bound = player.position.x + get_viewport_rect().size.x / 2
		var top_bound = player.position.y - get_viewport_rect().size.y / 2
		var bottom_bound = player.position.y + get_viewport_rect().size.y / 2
		print(get_viewport_rect().size)
		
		while (i < spawn_amount):
			rand_pos = create_pos(left_bound, right_bound, top_bound, bottom_bound)
			var enemy = AllEnemies.get_enemy().instance()
			enemy.position = rand_pos
			print("spawn")
			add_child(enemy)
			i += 1
	
		timer.start(spawn_time)

	


func _on_VisibilityNotifier2D_screen_entered():
	can_spawn = true

func create_pos(left_bound, right_bound, top_bound, bottom_bound):
	var x = rand_range(left_bound - 50, right_bound + 50)
	var y = rand_range(top_bound - 100, bottom_bound + 100)
	var rand_pos = Vector2(x,y)
	
	while (x == clamp(x, left_bound, right_bound)) and (y == clamp(y, top_bound, bottom_bound)):
		x = rand_range(left_bound - 50, right_bound + 50)
		y = rand_range(top_bound - 100, bottom_bound + 100)
		rand_pos = Vector2(x,y)
	
	return rand_pos
