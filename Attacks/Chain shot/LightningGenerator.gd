extends Node2D



export var sub_forkyfy = false 

var lightning_scene : PackedScene = preload("res://Attacks/Chain shot/ChainShot.tscn")

var fork_count = 1
var sub_fork_count = 0

var forks_array = []
var sub_fork_length = 200
var max_redirects
var redirects = 0
var exceptions = []

var from_to
var normal
var fork_offset = 300
var target
var length_offset = 1

func _ready():
	max_redirects = PlayerStats.attacks.ChainShot.stats.redirects


func _physics_process(_delta):
	global_position = Vector2(0,0)

func createLightning(pos = get_parent().global_position, exceptions = []):
	if !EnemyStats.get_closest_enemy_pos(pos, exceptions):
		return

	forks_array.clear()
	for fork in range(0, fork_count):
		var lightning_instance = lightning_scene.instance()
		
		if fork == 0:
			target = EnemyStats.get_closest_enemy_pos(pos, exceptions)
		else:
			length_offset = randf()
			target = (EnemyStats.get_closest_enemy_pos(pos, exceptions) + normal * rand_range(-fork_offset, fork_offset))
			
		from_to = target - pos
		
		if sub_forkyfy:
			sub_fork_count = from_to.length()/40
			sub_fork_length = from_to.length()/10
			
		normal = Vector2(from_to.y,-from_to.x).normalized()
		
		add_child(lightning_instance)
		lightning_instance.set_start(pos)
		lightning_instance.set_end(target)
		lightning_instance.segmentize(from_to, pos)
		lightning_instance.sway(normal)
		if redirects == 0:
			lightning_instance.audioStreamPlayer.play()
		lightning_instance.animationPlayer.play("Fade")
		forks_array.append(lightning_instance)
		
		if sub_fork_count > 0:
			for _sub_fork in range(0,sub_fork_count):
				var picked_fork = forks_array[int(rand_range(0, (forks_array.size() - 1)))]
				sub_forkyfy(normal, picked_fork.get_point_position(rand_range(0, picked_fork.get_point_count() - 1)))

func sub_forkyfy(normal, point):
	var lightning_instance = lightning_scene.instance()
	var sub_target = (point + normal * rand_range(-sub_fork_length, sub_fork_length)) - (target/4) * randf()
	var sub_from_to = sub_target - point
	var sub_normal = Vector2(sub_from_to.y,-sub_from_to.x).normalized()
	
	add_child(lightning_instance)
	lightning_instance.set_start(point)
	lightning_instance.set_end(sub_target)
	lightning_instance.segmentize(sub_from_to, point)
	lightning_instance.sway(sub_normal)

	lightning_instance.animationPlayer.play("Fade")


func _on_Timer_timeout():
	redirects = 0
	exceptions = []
	max_redirects = PlayerStats.attacks.ChainShot.stats.redirects
	if EnemyStats.enemies:
		createLightning()



func hit_enemy(pos, enemy):
	if redirects < max_redirects:
		exceptions.append(enemy)
		createLightning(pos, exceptions)

		redirects += 1


