extends Node

var player
var mouseControls = true

var time = 0.0
var score = 0 setget set_score

signal score_changed(value)

func _process(delta):
	time += delta

func set_score(value):
	score = value
	emit_signal("score_changed", value)
