extends KinematicBody2D

var moduleType

var direction = Vector2()
var speed = 250
var endPos = Vector2()

func throwFromTo(newStartPos: Vector2, newEndPos: Vector2):
	position = newStartPos
	endPos = newEndPos

func _physics_process(delta):
	direction = (endPos - position).normalized()
	var velocity = direction * speed
	var distanceFromEnd = (position - endPos).length()
	if (velocity * delta).length() < distanceFromEnd:
		move_and_slide(velocity)
	else:
		position = endPos