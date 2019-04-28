extends "res://Resources/Scripts/Modules/ModuleTypeBase.gd"

var EffectSlow = preload("res://Scenes/GameObjects/ModuleEffects/Slow/EffectSlow.tscn")

class_name ModuleTypeSlow

var slowEffectNode

func _init():
	spritePath = "res://Resources/Sprites/testModuleSprite2.png"

func start_effect(moduleNode: Node2D):
	slowEffectNode = EffectSlow.instance()
	moduleNode.add_child(slowEffectNode)
	slowEffectNode.activate()

func stop_effect(moduleNode: Node2D):
	moduleNode.remove_child(slowEffectNode)