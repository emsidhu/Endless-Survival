extends Control


func _ready() -> void:
	PlayerStats.resetStats()
	$Title.text = "Your Score Was " + str(Globals.score)




func _on_ChangeSceneBtn_button_up():
	PlayerStats.health = PlayerStats.max_health
