extends Node3D

var player_choice
var opponent_choice

# ----------- Bool -------------
var is_playing = false
var opponent_take_damage = false
var player_take_damage = false

# ----------- Reference -----------
@onready var player = $player
@onready var opponent = $opponent
@onready var rock_button = $hud/Panel/rock # ------------ Buttons
@onready var paper_button = $hud/Panel/paper
@onready var scissor_button = $hud/Panel/scissor
@onready var label: Label = $hud/Label # ------------ LABELS
@onready var label_result: Label = $hud/LabelResult

@onready var player_hearts: Array[Node] = [
	$hud/PlayerHearts/heart1,
	$hud/PlayerHearts/heart2,
	$hud/PlayerHearts/heart3
]
@onready var opponent_hearts: Array[Node] = [
	$hud/OpponentHearts/heart1,
	$hud/OpponentHearts/heart2,
	$hud/OpponentHearts/heart3
]



# ===============================================================================
func _ready() -> void:
	waiting()
	update_player_hearts(player.max_health)
	update_opponent_hearts(opponent.max_health)
# ===============================================================================



func play():
	if is_playing:
		return
	is_playing = true
	#start_label.visible = false
	label.text = ""
	label_result.text = ""

	rock_button.visible = true
	paper_button.visible = true
	scissor_button.visible = true
	#result_panel.visible = false

func waiting():
	is_playing = false
	#start_label.visible = true
	label.text = "press [SPACE]"
	label_result.text = ""
	player.mouse_capture()
	player.anim_player.play("anim/anim_breathing_idle")

func compare_choices():
	if player_choice == opponent_choice:
		draw()
	elif (player_choice == 0 and opponent_choice == 2) or (player_choice == 1 and opponent_choice == 0) or (player_choice == 2 and opponent_choice == 1):
		win()
	else:
		loose()

func show_obj():
	if opponent_choice == 0:
		opponent.show_rock()
	if opponent_choice == 1:
		opponent.show_paper()
	if opponent_choice == 2:
		opponent.show_scissor()
func draw():
	#draw_label.visible = true
	label_result.modulate = Color.GRAY
	label_result.text = "DRAW"
	await get_tree().create_timer(2).timeout
	#draw_label.visible = false
	label_result.text = ""
	player.hide_obj()
	opponent.hide_obj()
	waiting()

func win():
	label_result.modulate = Color.AQUAMARINE
	label_result.text = "WIN"
	await get_tree().create_timer(2).timeout

	label_result.text = ""
	player.slap()
	await get_tree().create_timer(0.2).timeout
	opponent.hit()
	await get_tree().create_timer(0.5).timeout
	if not opponent_take_damage:
		opponent_take_damage = true
		opponent.minus_health()
		update_opponent_hearts(opponent.current_health)
	await get_tree().create_timer(2.1).timeout # 3.1
	opponent_take_damage = false
	if opponent.current_health > 0:
		player.hide_obj()
		opponent.hide_obj()
		waiting()
	else:
		Autoloaded.is_win = true
		Autoloaded.current_money += Autoloaded.invested_money * 2 # ----------Money
		await get_tree().create_timer(1).timeout
		results()

func loose():
	label_result.modulate = Color.LIGHT_CORAL
	label_result.text = "LOOSE"
	await get_tree().create_timer(2).timeout

	label_result.text = ""
	opponent.slap() # ------------Slap animation
	await get_tree().create_timer(0.2).timeout
	player.hit() # -------------Hurt animation
	await get_tree().create_timer(0.5).timeout
	if not player_take_damage:
		player_take_damage = true
		player.minus_health() # -------take damage
		update_player_hearts(player.current_health) # ---------UI hearts
	await get_tree().create_timer(2.1).timeout # 3.1
	player_take_damage = false
	if player.current_health > 0:
		player.hide_obj()
		opponent.hide_obj()
		waiting()
	else:
		Autoloaded.is_win = false
		await get_tree().create_timer(1).timeout
		results()

func update_player_hearts(health: int):
	for i in range(3):
		player_hearts[i].visible = i < health

func update_opponent_hearts(health: int):
	for i in range(3):
		opponent_hearts[i].visible = i < health

func _on_rock_pressed() -> void:
	#player_is_rock = true
	player_choice = 0
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false

	opponent_choice = opponent.pick_random()
	await countdown()
	#await get_tree().create_timer(3).timeout
	player.show_rock()
	show_obj()

	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func _on_paper_pressed() -> void:
	#player_is_paper = true
	player_choice = 1
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false

	opponent_choice = opponent.pick_random()
	await countdown()
	#await get_tree().create_timer(3).timeout
	player.show_paper()
	show_obj()

	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func _on_scissor_pressed() -> void:
	#player_is_scissor = true
	player_choice = 2
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false

	opponent_choice = opponent.pick_random()
	await countdown()
	#await get_tree().create_timer(3).timeout
	player.show_scissor()
	show_obj()

	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func countdown():
	#rock_label.visible = true
	label.text = "rock"
	await get_tree().create_timer(1).timeout
	#rock_label.visible = false
	label.text = "paper"
	#paper_label.visible = true
	await get_tree().create_timer(1).timeout
	#paper_label.visible = false
	label.text = "scissor"
	#scissor_label.visible = true
	await get_tree().create_timer(1).timeout
	#scissor_label.visible = false
	label.text = ""

func results():
	if not is_inside_tree():   # fix bug where if player loose game crash before changing to results scene 
		return
	get_tree().change_scene_to_file("res://scene/results.tscn")
