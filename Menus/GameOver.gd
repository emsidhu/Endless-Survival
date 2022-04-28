extends Control


func _ready() -> void:
	
	$Title.text = "Your Score Was " + str(Globals.score)
	PlayerStats.resetStats()




func _on_ChangeSceneBtn_button_up():
	PlayerStats.health = PlayerStats.max_health
