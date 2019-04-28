extends "res://Resources/Scripts/Modules/ModuleTypeBase.gd"

var EffectFire = preload("res://Scenes/GameObjects/ModuleEffects/Fire/EffectFire.tscn")

class_name ModuleTypeFire

var fireEffectNode

func _init():
	spritePath = "res://Resources/Sprites/testModuleSprite2.png"

func start_effect(moduleNode: Node2D):
	fireEffectNode = EffectFire.instance()
	moduleNode.add_child(fireEffectNode)
	fireEffectNode.connect("ready", fireEffectNode, "activate");

func stop_effect(moduleNode: Node2D):
	moduleNode.remove_child(fireEffectNode)