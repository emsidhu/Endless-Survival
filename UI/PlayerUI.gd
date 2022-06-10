extends Control

onready var healthbar = $Healthbar
onready var xpbar = $XPbar
onready var pauseMenu = $PauseMenu
onready var upgradeScreen = $UpgradeScreen
onready var upgradeBtn1 = $UpgradeScreen/VBoxContainer/UpgradeBtn1
onready var upgradeBtn2 = $UpgradeScreen/VBoxContainer/UpgradeBtn2
onready var upgradeBtn3 = $UpgradeScreen/VBoxContainer/UpgradeBtn3
onready var vBoxContainer = $PauseMenu/VBoxContainer
onready var resumeBtn = $PauseMenu/VBoxContainer/ResumeBtn
onready var optionsBtn = $PauseMenu/VBoxContainer/OptionsBtn
#onready var changeSceneBtn = $PauseMenu/VBoxContainer/ChangeSceneBtn
#onready var quitBtn = $PauseMenu/VBoxContainer/QuitBtn
#onready var fullScreenBtn = $PauseMenu/VBoxContainer/FullScreenBtn
onready var mouseControlsBtn = $PauseMenu/VBoxContainer/MouseControlsBtn
onready var audioStreamPlayer = $AudioStreamPlayer

var choice1
var choice2
var choice3
var type1
var type2
var type3

var max_health = 1000
var health = 1000
var xp = 0
var max_xp = 1000
var error
var upgradeStatRef = funcref(PlayerStats, "upgradeStat")
var upgradeAttackRef = funcref(PlayerStats, "upgradeAttack")

func _ready():
	Globals.time = 0
	var canvas_rid = get_canvas_item()
	# You may need to adjust these values
	VisualServer.canvas_item_set_draw_index(canvas_rid, 100)
	VisualServer.canvas_item_set_z_index(canvas_rid, 100)
	max_health = PlayerStats.max_health
	health = PlayerStats.health
	max_xp = PlayerStats.max_xp
	pauseMenu.visible = false
	upgradeScreen.visible = false
	error = PlayerStats.connect("health_changed", self, "set_health")
	error = PlayerStats.connect("max_health_changed", self, "set_max_health")
	error = PlayerStats.connect("xp_changed", self, "set_xp")
	error = PlayerStats.connect("max_xp_changed", self, "set_max_xp")
	error = PlayerStats.connect("level_up", self, "level_up")
	
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
	if event.is_action_pressed("pause") and !upgradeScreen.visible:
		get_tree().paused = !get_tree().paused
		pauseMenu.visible = !pauseMenu.visible
		
		if resumeBtn.visible != true:
			for child in vBoxContainer.get_children():
				child.visible = !child.visible
				optionsBtn.visible = true
				optionsBtn.grab_focus()
		else:
			resumeBtn.grab_focus()
		
			
func _on_ResumeBtn_button_up():
	get_tree().paused = false
	pauseMenu.visible = false


func level_up():
	get_tree().paused = true
	upgradeScreen.visible = true
	
	var num_attacks = range(PlayerStats.attacks.size())
	var num_stats = range(PlayerStats.stats.size())

	var i = 0
	while i < 3:
		var upgradeInfo
		while true:
			match (randi() % 2):
				0:
					upgradeInfo = choose_upgrade(num_attacks, "attacks")
					num_attacks.erase(upgradeInfo[0])
					if upgradeInfo[1].level < upgradeInfo[1].max_level:	
						break
					
				1:
					upgradeInfo = choose_upgrade(num_stats, "stats")
					num_stats.erase(upgradeInfo[0])
					if upgradeInfo[1].level < upgradeInfo[1].max_level:	
						break
					

		#assigns type variables to whatever type the upgrade is, an attack or a stat
		set("type" + str(i+1), upgradeInfo[1].type)
		#assigns choice variables to the key of the upgrade
		set("choice" + str(i+1), upgradeInfo[2])
		
		var upgradeBtn = get("upgradeBtn" + str(i+1))
		upgradeBtn.title.text = upgradeInfo[1].upgradeInfo.title
		upgradeBtn.upgradeText.text = upgradeInfo[1].upgradeInfo.upgradeText
		upgradeBtn.level.text = "LV " + str(upgradeInfo[1].level)
	#	upgradeBtn.upgradeIcon.texture = upgradeInfo[1].upgradeInfo.icon
		
		i += 1
	upgradeBtn1.grab_focus()

func _on_UpgradeBtn_button_up(number):
	#uses type to see what function reference to use, then calls it with the correct key using choice
	get("upgrade" + get("type" + str(number)) + "Ref").call_func(get("choice" + str(number)))
	
	get_tree().paused = false
	upgradeScreen.visible = false
	
func choose_upgrade(array, type):
	var number = array[randi() % array.size()]
	var choice = PlayerStats[type].keys()[number]
	var upgrade = PlayerStats[type][choice]
	return [number, upgrade, choice]



func _on_OptionsBtn_button_up():

	for child in vBoxContainer.get_children():
			child.visible = !child.visible
	optionsBtn.visible = true
	if resumeBtn.visible == true:
		optionsBtn.text = "Options"
		resumeBtn.grab_focus()
	else:
		optionsBtn.text = "Return"
		mouseControlsBtn.grab_focus()


func _on_AudioStreamPlayer_finished():
	audioStreamPlayer.playing = false
	



func _on_button_down():
	audioStreamPlayer.playing = true
