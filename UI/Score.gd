extends Label

var error 

func _ready():
	error = Globals.connect("score_changed", self, "update_score")

func update_score(value):
	text = str(value)
