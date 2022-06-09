extends Control

onready var audioStreamPlayer = $AudioStreamPlayer
onready var nameInput = $ColorRect/DeathScreen/NameInput

func _ready() -> void:
	$ColorRect/DeathScreen/Score.text = "Your Score Was " + str(Globals.score) + "!"
	Globals.loadScores()


func _on_AudioStreamPlayer_finished():
	audioStreamPlayer.playing = false


func _on_button_down():
	audioStreamPlayer.playing = true

func updateLeaderboard():
	var allScores = Globals.AllScores
	var leaderboard = $ColorRect/Leaderboard/ColorRect/VBoxContainer
	var i = 1
	var places = leaderboard.get_children()
	for player in allScores:
		if i > 5:
			break
		places[i].get_child(1).text = player.name
		places[i].get_child(2).text = str(player.score)
		i += 1
		
	


func _on_Confirm_button_up():
	Globals.AllScores.append({"name": nameInput.text, "score": Globals.score})

	$ColorRect/DeathScreen.visible = false
	updateLeaderboard()
	$ColorRect/Leaderboard.visible = true
	Globals.saveScores()
