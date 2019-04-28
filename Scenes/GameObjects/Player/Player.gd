extends KinematicBody2D

var Module = preload("res://Scenes/GameObjects/Module/Module.tscn")
var ModuleTypeBase = preload("res://Resources/Scripts/Modules/ModuleTypeBase.gd")
var ModuleTypeParticles = preload("res://Resources/Scripts/Modules/ModuleTypeParticles.gd")
var ModuleQueue = preload("res://Resources/Scripts/ModuleQueue.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 250
var direction = Vector2()

var moduleQueue = ModuleQueue.new()

func _ready():
	add_to_group("players")
	
	moduleQueue.push_module(ModuleTypeBase.new())
	moduleQueue.push_module(ModuleTypeParticles.new())
	moduleQueue.push_module(ModuleTypeParticles.new())
	moduleQueue.push_module(ModuleTypeParticles.new())
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
	if moduleQueue.is_empty():
		return
	
	var viewportPos = get_global_transform_with_canvas().get_origin()
	var mouseViewportPos = get_viewport().get_mouse_position()
	var attackDir = (mouseViewportPos - viewportPos).normalized()
	
	var module = Module.instance()
	module.set_module_type(moduleQueue.pop_module())
	get_owner().add_child(module)
	module.throwFromTo(position, get_global_mouse_position())

func collectModule(moduleType: ModuleTypeBase):
	moduleQueue.push_module(moduleType)

func _physics_process(delta):
	handle_input()
	move_and_slide(direction.normalized() * speed)
