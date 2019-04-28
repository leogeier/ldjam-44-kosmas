extends Object

class_name ModuleTypeBase

var activated = false
var curModuleNode
var spritePath = "res://Resources/Sprites/testModuleSprite.png"

# Do not override these methods to create effect behaviour
func activateEffect(moduleNode: Node2D):
	if not activated:
		curModuleNode = moduleNode
		activated = true
		start_effect(curModuleNode)
		

func deactivateEffect():
	if activated:
		activated = false
		stop_effect(curModuleNode)

# Override these methods instead
func start_effect(moduleNode: Node2D):
	print("Start Base ModuleType Effect")

func stop_effect(moduleNode: Node2D):
	print("Stop Base ModuleType Effect")

func get_sprite_path():
	return spritePath