extends "res://Resources/Scripts/Modules/ModuleTypeBase.gd"

var EffectParticles = preload("res://Scenes/GameObjects/ModuleEffects/Particles/EffectParticles.tscn")

class_name ModuleTypeParticles

var particleEffectNode

func start_effect(moduleNode: Node2D):
	particleEffectNode = EffectParticles.instance()
	moduleNode.add_child(particleEffectNode)
	particleEffectNode.activate()

func stop_effect(moduleNode: Node2D):
	moduleNode.remove_child(particleEffectNode)