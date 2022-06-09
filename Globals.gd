extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

var player
var mouseControls = true
var scoreboardName

var time = 0.0
var score = 0 setget set_score
var AllScores = [] setget , get_AllScores



const POISON = preload("res://Effects/Status/Poison.tscn")
const POISONMODULATE = Color(0, 0.89, 0)
const BURN = preload("res://Effects/Status/Burn.tscn")
const BURNMODULATE = Color(0.89, 0, 0)

var burnDamage = 0.25
var poisonDamage = 0.25

signal score_changed(value)

class CustomSort:
	static func sort_descending(a, b):
		if a.score > b.score:
			return true
		return false



func _process(delta):
	time += delta

func set_score(value):
	score = value
	emit_signal("score_changed", value)
	

func get_AllScores():
	AllScores.sort_custom(CustomSort, "sort_descending")
	return AllScores
	
	

func saveScores():
	var data = {
		"AllScores": AllScores
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)

	if error == OK:
		file.store_var(data)
		file.close()

func loadScores():
	var file = File.new()
	var error = file.open(save_path, File.READ)
	
	if error == OK:
		var data = file.get_var()
		file.close()
		AllScores = data["AllScores"]


