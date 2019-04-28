extends Node2D

var startTime = null
var validPeriod = 1000

func activate():
	startTime = OS.get_ticks_msec()
	get_node("CPUParticles2D").set_emitting(true)

func _ready():
	activate()


func _on_Area2D_body_entered(body):
	if OS.get_ticks_msec() - startTime > validPeriod:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.has(body):
		body.Kill()
