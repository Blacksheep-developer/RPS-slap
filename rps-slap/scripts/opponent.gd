extends Node3D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
enum choice { ROCK, PAPER, SCISSOR}
var current_choice: choice

@onready var rock_obg = $Skeleton/BoneAttachment3D/rock
@onready var paper_obg = $Skeleton/BoneAttachment3D/paper
@onready var scissor_obg = $Skeleton/BoneAttachment3D/scissor

@onready var gamemanager = owner

var max_health = 3
var current_health
const BLEND_TIME = 0.4



# ==============================================================================
func _ready() -> void:
	randomize()
	current_health = max_health
# ==============================================================================



func pick_random() -> choice:
	current_choice = choice.values().pick_random()
	print(choice.keys()[current_choice])
	return current_choice

func slap():
	anim_player.play("opponent/slap", BLEND_TIME)
func hit():
	anim_player.play("opponent/hit", BLEND_TIME)
func idle():
	anim_player.play("opponent/idle", BLEND_TIME)
func reveal():
	anim_player.play("opponent/reveal", BLEND_TIME)

func minus_health():
	current_health -= 1

func show_rock():
	rock_obg.visible = true
func show_paper():
	paper_obg.visible = true
func show_scissor():
	scissor_obg.visible = true

func hide_obj():
	rock_obg.visible = false
	paper_obg.visible = false
	scissor_obg.visible = false
