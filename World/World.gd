extends Node2D

onready var enemyTimer = $EnemyTimer
onready var pickupTimer = $PickupTimer
onready var player = $YSort/PlayerContainer/Player
onready var ySort = $YSort


export var pickup_spawn_time = 2
export var pickup_spawn_amount = 2
var can_spawn = false

func ready():
	randomize()


func _on_EnemyTimer_timeout():
	if  (is_instance_valid(player)):
		var i = 0
		while (i < round(EnemyStats.enemySpawnAmount)):
			create_child(AllEnemies.get_enemy(), 50, 100)
			i += 1
		enemyTimer.start(EnemyStats.enemySpawnTime)
		
func _on_PickupTimer_timeout():
	if  (is_instance_valid(player)):
		var i = 0
		while (i < pickup_spawn_amount):
			create_child(AllPickups.get_pickup(), 200, 300)
			i += 1
		pickupTimer.start(pickup_spawn_time)

func create_child(instance, x_change, y_change):
	instance.position = create_pos(create_bounds(), x_change, y_change)
	ySort.add_child(instance)

func create_pos(bounds, x_change, y_change):
	
	print(bounds)
	var x = rand_range(bounds[0] - x_change, bounds[1] + x_change)
	var y = rand_range(bounds[2] - y_change, bounds[3] + y_change)
	var rand_pos = Vector2(x,y)
	
	while (x == clamp(x, bounds[0], bounds[1])) and (y == clamp(y, bounds[2], bounds[3])):
		x = rand_range(bounds[0] - x_change, bounds[1] + x_change)
		y = rand_range(bounds[2] - y_change, bounds[3] + y_change)
		rand_pos = Vector2(x,y)
	
	return rand_pos
	
func create_bounds():
	var left_bound = player.position.x - ((get_viewport_rect().size.x / 2) * 1.3)
	var right_bound = player.position.x + ((get_viewport_rect().size.x / 2) * 1.3)
	var top_bound = player.position.y - ((get_viewport_rect().size.y / 2) * 1.3)
	var bottom_bound = player.position.y + ((get_viewport_rect().size.y / 2) * 1.3)
	return [left_bound, right_bound, top_bound, bottom_bound]



