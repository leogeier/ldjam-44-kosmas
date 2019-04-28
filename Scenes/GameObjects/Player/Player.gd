extends KinematicBody2D

var ModuleTypeBase = preload("res://Resources/Scripts/Modules/ModuleTypeBase.gd")
var ModuleTypeParticles = preload("res://Resources/Scripts/Modules/ModuleTypeParticles.gd")
var ModuleTypeSlow = preload("res://Resources/Scripts/Modules/ModuleTypeSlow.gd")
var ModuleTypeFire = preload("res://Resources/Scripts/Modules/ModuleTypeFire.gd")
var ModuleQueue = preload("res://Resources/Scripts/ModuleQueue.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var speed = 250
var direction = Vector2()

var moduleQueue = ModuleQueue.new()

func _ready():
	add_to_group("players")
	add_to_group("RaiderTargets")
	
	moduleQueue.push_module_type(ModuleTypeFire.new())
	moduleQueue.push_module_type(ModuleTypeFire.new())
	moduleQueue.push_module_type(ModuleTypeFire.new())
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
	
	var attackDir = (get_global_mouse_position() - global_position).normalized()
	
	var module = moduleQueue.pop_module()
	get_owner().add_child(module)
	module.throwTowards(position, attackDir)

func collectModule(moduleType: ModuleTypeBase):
	moduleQueue.push_module_type(moduleType)

func _physics_process(delta):
	handle_input()
	AnimationSelector(direction)
	move_and_slide(direction.normalized() * speed)
	
	
#Henrik Functions
func steal():
	return moduleQueue.pop_module_type()				#Only temporary
	
func is_collectable():
	return true
	
func AnimationSelector(direction):
	if(direction.length() < 0.01):
		#$AnimatedSprite.play("DownIdle")
		if($AnimatedSprite.animation == "Side"):
			$AnimatedSprite.play("SideIdle")
		if($AnimatedSprite.animation == "Up"):
			$AnimatedSprite.play("UpIdle")
		if($AnimatedSprite.animation == "Down"):
			$AnimatedSprite.play("DownIdle")
		return
	if(direction.abs().x > direction.abs().y):
		$AnimatedSprite.play("Side")
		$AnimatedSprite.set_flip_h(true)
		if(direction.x > 0):
			$AnimatedSprite.set_flip_h(false)
	else:
		$AnimatedSprite.play("Up")
		if(direction.y > 0):
			$AnimatedSprite.play("Down")

