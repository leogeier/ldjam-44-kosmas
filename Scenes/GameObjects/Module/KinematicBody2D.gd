extends KinematicBody2D

var direction = Vector2()
var speed = 250
var endPos = Vector2()

func throwFromTo(newStartPos: Vector2, newEndPos: Vector2):
	#get_owner().position = newStartPos
	direction = (newEndPos - newStartPos).normalized()
	endPos = newEndPos
	print(newEndPos)

func _physics_process(delta):
	var velocity = direction * speed
	var distanceFromEnd = (position - endPos).length()
	if velocity.length() < distanceFromEnd:
		move_and_slide(velocity)
	else:
		position = endPos