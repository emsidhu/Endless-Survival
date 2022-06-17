extends Control

onready var audioStreamPlayer = $AudioStreamPlayer
onready var nameInput = $ColorRect/DeathScreen/NameInput
onready var deathScreen = $ColorRect/DeathScreen
onready var leaderboard = $ColorRect/Leaderboard

func _ready() -> void:
	visible = false
	deathScreen.visible = true
	leaderboard.visible = false
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
	i = 1
	for player in allScores:
		if i > 5 and player.name == nameInput.text and player.score == Globals.score:

			places[8].get_child(0).text = str(allScores.find(player) + 1)
			places[8].get_child(1).text = player.name
			places[8].get_child(2).text = str(player.score)
			
			var prev = allScores[allScores.find(player) - 1]
			places[7].get_child(0).text = str(allScores.find(prev) + 1)
			places[7].get_child(1).text = prev.name
			places[7].get_child(2).text = str(prev.score)

			if allScores.find(player) < allScores.size() - 1:
				
				var next = allScores[allScores.find(player) + 1]
				places[9].get_child(0).text = str(allScores.find(next) + 1)
				places[9].get_child(1).text = next.name
				places[9].get_child(2).text = str(next.score)
			
			break

		i += 1


func _on_Confirm_button_up():
	Globals.AllScores.append({"name": nameInput.text, "score": Globals.score})

	$ColorRect/DeathScreen.visible = false
	updateLeaderboard()
	$ColorRect/Leaderboard.visible = true
	Globals.saveScores()
	$ColorRect/Leaderboard/ChangeSceneBtn.grab_focus()
