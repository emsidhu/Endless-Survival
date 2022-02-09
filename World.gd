extends Node2D

onready var timer = $Timer
onready var player = $YSort/Player
onready var ySort = $YSort

export var spawn_time = 1
export var spawn_amount = 1


func _on_Timer_timeout():
	var rand_pos = Vector2(0,0)
	var i = 0
	while (i < spawn_amount):
		while (rand_pos.distance_to(player.position) > get_viewport().size.x / 2):
			var x = rand_range(player.position.x - 50 - (get_viewport().size.x / 2), player.position.x + 50 + (get_viewport().size.x / 2))
			var y = rand_range(player.position.y - 50 - (get_viewport().size.y / 2), player.position.y + 50 + (get_viewport().size.y / 2))
			rand_pos = Vector2(x,y)

		var enemy = AllEnemies.get_enemy().instance()
		enemy.position = rand_pos
		add_child(enemy)
		i += 1
	
	timer.start(spawn_time)
	


	

	
