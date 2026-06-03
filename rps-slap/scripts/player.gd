extends Node3D


@onready var opponent = get_node("../opponent") # Reference to the opponent node in the scene tree

var target_y: float = 89.5 # Target Y rotation angle for lerping towards the opponent

var rotating: bool = false # Whether the player is currently lerping rotation

var rotation_speed: float = 3 # Speed of the lerp rotation

var mouse_sensitivity: float = 0.002 # Sensitivity of mouse-based horizontal rotation

var mouse_rotation_enabled: bool = true # Flag to disable mouse rotation after pressing space

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Capture the mouse so it's hidden and locked to the window

func _input(event: InputEvent) -> void:
	# Only allow mouse rotation if mouse_rotation_enabled is true
	if event is InputEventMouseMotion and mouse_rotation_enabled:
		rotate_y(-event.relative.x * mouse_sensitivity)
	
func _process(delta: float) -> void:
	# When the "start" action (spacebar) is pressed
	if Input.is_action_just_pressed("start"):
		# Show the mouse cursor again
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_rotation_enabled = false # Disable further mouse-based rotation
		#var direction = opponent.global_position - global_position # Calculate the direction to the opponent
		#target_y = atan2(direction.x, direction.z) # Compute the target Y angle to face the opponent
		rotating = true
	
	# Smoothly rotate towards the opponent
	if rotating:
		rotation.y = lerp_angle(rotation.y, target_y, rotation_speed * delta)
		# Snap to exact target when close enough to avoid micro-adjustments
		if abs(rotation.y - target_y) < 0.01:
			rotation.y = target_y
			rotating = false
