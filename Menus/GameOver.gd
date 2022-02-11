extends Control


func _ready() -> void:
	PlayerStats.damage = 50
	PlayerStats.max_health = 1000




func _on_ChangeSceneBtn_button_up():
	PlayerStats.health = PlayerStats.max_health
