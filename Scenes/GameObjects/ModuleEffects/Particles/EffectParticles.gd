extends Node2D

func activate():
	get_node("CPUParticles2D").set_emitting(true)

func _ready():
	activate()
