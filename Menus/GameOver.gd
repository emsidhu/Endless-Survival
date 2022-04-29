extends Control


func _ready() -> void:
	$Title.text = "Your Score Was " + str(Globals.score)
	$Menu/ChangeSceneBtn.grab_focus()


func _on_ChangeSceneBtn_button_up():
	PlayerStats.resetStats()
