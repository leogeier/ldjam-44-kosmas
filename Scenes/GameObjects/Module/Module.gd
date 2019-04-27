extends KinematicBody2D

var moduleType

var direction = Vector2()
var speed = 250
var endPos = Vector2()
var reachedEnd = true

func throwFromTo(newStartPos: Vector2, newEndPos: Vector2):
	position = newStartPos
	endPos = newEndPos
	reachedEnd = false

func _physics_process(delta):
	if not reachedEnd:
		rotate(0.1)
		direction = (endPos - position).normalized()
		var velocity = direction * speed * delta
		var distanceFromEnd = (position - endPos).length()
		if velocity.length() < distanceFromEnd:
			var collision = move_and_collide(velocity)
			if collision != null:
				reachedEnd = true
		else:
			position = endPos
			reachedEnd = true