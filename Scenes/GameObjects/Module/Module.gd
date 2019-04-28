extends KinematicBody2D

var moduleType: ModuleTypeBase

var direction = Vector2()
var velocity = Vector2()
var startSpeed = 350
var maxAngularSpeed = 0.2
var startAngularSpeed = 0
var reachedEnd = true
onready var TweenNode = get_node("Tween")

func _ready():
	add_to_group("RaiderTargets")

func set_module_type(newModuleType: ModuleTypeBase):
	moduleType = newModuleType
	get_node("Sprite").set_texture(load(moduleType.get_sprite_path()))

func get_module_type():
	return moduleType

# newDirection should be normalized
func throwTowards(startPoint: Vector2, newDirection: Vector2):
	position = startPoint
	direction = newDirection
	reachedEnd = false
	velocity = direction * startSpeed
	TweenNode.interpolate_property(self, "velocity", velocity, Vector2(0,0), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	TweenNode.start()
	startAngularSpeed = maxAngularSpeed * rand_range(0.8, 1.4)

func endThrow():
	reachedEnd = true
	moduleType.activateEffect(self)
	TweenNode.remove_all()

func is_collectable():
	return reachedEnd

func collectBy(player):
	moduleType.deactivateEffect()
	player.collectModule(moduleType)
	get_parent().remove_child(self)

func _physics_process(delta):
	if not reachedEnd:
		var curSpeed = velocity.length()
		if curSpeed == 0:
			endThrow()
		
		rotate(startAngularSpeed * (curSpeed / startSpeed))
		
		var collision = move_and_collide(velocity * delta)
		if collision != null:
			endThrow()
			
func steal():
	get_parent().remove_child(self)
	return get_module_type()
	
