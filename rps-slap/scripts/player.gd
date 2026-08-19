extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var game: Node3D = get_node("..")

@onready var rock_obg = $mannequin/Skeleton3D/BoneAttachment3D2/rock
@onready var paper_obg = $mannequin/Skeleton3D/BoneAttachment3D2/paper
@onready var scissor_obg = $mannequin/Skeleton3D/BoneAttachment3D2/scissor

enum choice { ROCK, PAPER, SCISSOR}

var target_y: float = 89.5

var rotating: bool = false

var rotation_speed: float = 3

var mouse_sensitivity: float = 0.002

var mouse_rotation_enabled: bool = true

var max_health = 3
var current_health
@onready var gamemanager = owner



# =================================================================================================
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	current_health = max_health

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_rotation_enabled:
		rotate_y(-event.relative.x * mouse_sensitivity)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		if game.is_playing:
			return
		game.play()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_rotation_enabled = false
		rotating = true
	
	if rotating:
		rotation.y = lerp_angle(rotation.y, target_y, rotation_speed * delta)
		if abs(rotation.y - target_y) < 0.01:
			rotation.y = target_y
			rotating = false
# =================================================================================================



func slap():
	anim_player.play("anim/anim_right_hook")

func hit():
	anim_player.play("anim/anim_kick_to_the_groin")

func minus_health():
	current_health -= 1
	#if current_health <= 0:
		#gamemanager.back_to_menu()
	
func mouse_capture():
	mouse_rotation_enabled = true
	rotating = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
