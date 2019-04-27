extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 250
var direction = Vector2()

func _ready():
	pass # Replace with function body.

func handle_input():
	# Movement
	direction = Vector2()
	if Input.is_action_pressed('ui_right'):
		direction.x = 1
	if Input.is_action_pressed('ui_left'):
		direction.x = -1
	if Input.is_action_pressed('ui_down'):
		direction.y = 1
	if Input.is_action_pressed('ui_up'):
		direction.y = -1
	
	# Module throw
	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	var viewportPos = get_global_transform_with_canvas().get_origin()
	var mouseViewportPos = get_viewport().get_mouse_position()
	var attackDir = (mouseViewportPos - viewportPos).normalized()
	print(attackDir)

func _physics_process(delta):
	handle_input()
	move_and_slide(direction * speed)
