extends Node

var player
var mouseControls = true

var time = 0.0
var score = 0 setget set_score

const POISON = preload("res://Effects/Status/Poison.tscn")
const POISONMODULATE = Color(0, 0.89, 0)
const BURN = preload("res://Effects/Status/Burn.tscn")
const BURNMODULATE = Color(0.89, 0, 0)

var burnDamage = 0.25
var poisonDamage = 0.25

signal score_changed(value)

func _process(delta):
	time += delta

func set_score(value):
	score = value
	emit_signal("score_changed", value)



	
