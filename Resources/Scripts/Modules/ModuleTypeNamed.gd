# This class outputs it's name for debug purposes

extends "res://Resources/Scripts/Modules/ModuleTypeBase.gd"

class_name ModuleTypeNamed

var name

func _init(newName="unnamed"):
	name = newName

func activateEffect():
	print("Activated effect of " + name)
