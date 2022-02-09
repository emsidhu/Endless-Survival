extends Control

onready var healthbar = $Healthbar
onready var xpbar = $XPbar
onready var pauseMenu = $PauseMenu

var max_health = 1000
var health = 1000
var xp = 0
var max_xp = 1000

func _ready():
	var canvas_rid = get_canvas_item()
	# You may need to adjust these values
	VisualServer.canvas_item_set_draw_index(canvas_rid, 100)
	VisualServer.canvas_item_set_z_index(canvas_rid, 100)
	max_health = PlayerStats.max_health
	health = PlayerStats.health
	max_xp = PlayerStats.max_xp
	PlayerStats.connect("health_changed", self, "set_health")
	PlayerStats.connect("max_health_changed", self, "set_max_health")
	PlayerStats.connect("xp_changed", self, "set_xp")
	PlayerStats.connect("max_xp_changed", self, "set_max_xp")
	
func set_health(value):
	health = clamp(value, 0, max_health)
	if healthbar != null:
		healthbar.rect_size.x = 249 + (464 * health/max_health)
	
func set_max_health(value):
	max_health = value

func set_xp(value):
	xp = clamp(value, 0, max_xp)
	if xpbar != null:
		xpbar.rect_size.x = 249 + (464 * xp/max_xp)
		
func set_max_xp(value):
	max_xp = value

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pauseMenu.visible = !pauseMenu.visible
		

func _on_ResumeBtn_button_up():
	get_tree().paused = !get_tree().paused
	pauseMenu.visible = !pauseMenu.visible
	

