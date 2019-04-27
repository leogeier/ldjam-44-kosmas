#module.gd
extends KinematicBody2D

const module_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

func _process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * module_speed
	set_pos(get_pos() + motion * delta)