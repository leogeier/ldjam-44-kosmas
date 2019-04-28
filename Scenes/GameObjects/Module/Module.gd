extends KinematicBody2D

var moduleType: ModuleTypeBase

var direction = Vector2()
var speed = 250
var endPos = Vector2()
var reachedEnd = true

func set_module_type(newModuleType: ModuleTypeBase):
	moduleType = newModuleType

func get_module_type():
	return moduleType

func throwFromTo(newStartPos: Vector2, newEndPos: Vector2):
	position = newStartPos
	endPos = newEndPos
	reachedEnd = false

func endThrow():
	reachedEnd = true
	moduleType.activateEffect()

func is_collectable():
	return reachedEnd

func collectBy(player):
	moduleType.deactivateEffect()
	player.collectModule(moduleType)
	get_parent().remove_child(self)

func _physics_process(delta):
	if not reachedEnd:
		rotate(0.1)
		direction = (endPos - position).normalized()
		var velocity = direction * speed * delta
		var distanceFromEnd = (position - endPos).length()
		if velocity.length() < distanceFromEnd:
			var collision = move_and_collide(velocity)
			if collision != null:
				endThrow()
		else:
			position = endPos
			endThrow()