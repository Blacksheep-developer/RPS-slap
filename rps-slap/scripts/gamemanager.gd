extends Node3D

var is_playing = false

@onready var player = $player
@onready var opponent = $opponent

#var player_is_rock
#var player_is_paper
#var player_is_scissor
var player_choice
var opponent_choice
#var opponent_is_rock
#var opponent_is_paper
#var opponent_is_scissor
@onready var rock_button = $hud/Panel/rock
@onready var paper_button = $hud/Panel/paper
@onready var scissor_button = $hud/Panel/scissor
@onready var start_label = $hud/start_label
@onready var draw_label = $hud/draw_label
@onready var win_label = $hud/win_label
@onready var loose_label = $hud/loose_label
@onready var rock_label = $hud/rock_label
@onready var paper_label = $hud/paper_label
@onready var scissor_label = $hud/scissor_label

###############################################################################
func _ready() -> void:
	waiting()
	
	draw_label.visible = false
	win_label.visible = false
	win_label.visible = false
###############################################################################

func play():
	if is_playing:
		return
	is_playing = true
	start_label.visible = false
	
	rock_button.visible = true
	paper_button.visible = true
	scissor_button.visible = true
	
	#await get_tree().create_timer(7).timeout
	#is_playing = false
	

func waiting():
	is_playing = false
	start_label.visible = true
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
	draw_label.visible = true
	await get_tree().create_timer(2).timeout
	draw_label.visible = false
	player.hide_obj()
	opponent.hide_obj()
	waiting()

func win():
	win_label.visible = true
	await get_tree().create_timer(2).timeout
	win_label.visible = false
	player.slap()
	await get_tree().create_timer(0.2).timeout
	opponent.hit()
	await get_tree().create_timer(3.1).timeout
	player.hide_obj()
	opponent.hide_obj()
	waiting()
	
func loose():
	loose_label.visible = true
	await get_tree().create_timer(2).timeout
	loose_label.visible = false
	opponent.slap()
	await get_tree().create_timer(0.2).timeout
	player.hit()
	await get_tree().create_timer(3.1).timeout
	player.hide_obj()
	opponent.hide_obj()
	waiting()

func _on_rock_pressed() -> void:
	#player_is_rock = true
	player_choice = 0
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false
	
	opponent_choice = opponent.pick_random()
	countdown()
	await get_tree().create_timer(3).timeout
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
	countdown()
	await get_tree().create_timer(3).timeout
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
	countdown()
	await get_tree().create_timer(3).timeout
	player.show_scissor()
	show_obj()
	
	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func countdown():
	rock_label.visible = true
	await get_tree().create_timer(1).timeout
	rock_label.visible = false
	paper_label.visible = true
	await get_tree().create_timer(1).timeout
	paper_label.visible = false
	scissor_label.visible = true
	await get_tree().create_timer(1).timeout
	scissor_label.visible = false
