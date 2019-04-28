extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Raider = preload("res://Scenes/GameObjects/Raider/Raider.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Empty")
	add_to_group("Spawners")
	pass # Replace with function body.

func Visible():
	return $VisibilityNotifier2D.is_on_screen()

func Spawn():
	#print("Spawned")
	if !Visible():
		var RaiderBorn = Raider.instance()
		get_tree().get_root().add_child(RaiderBorn)
		RaiderBorn.position = global_position
		RaiderBorn.move_and_slide((Vector2(randi() % 5 + -5,randi() % 5 + -5) ))
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
