extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var DifficultyIncrease = 1
export (int) var DifficultyLevelSeconds = 25
export (int) var StartRaiders = 4
var SpawnFlag = false
var Difficulty = 0
var TimePassed = 0
var GlobalTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Empty")

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if((StartRaiders > 0) && (TimePassed > 0.5)):
		TimePassed = 0
		if Spawn():
			StartRaiders = StartRaiders - 1
			#print("Spawn the Spawn!")
	TimePassed = TimePassed + delta
	GlobalTime = GlobalTime + delta
	
	Difficulty = DifficultyLevelSeconds + ((GlobalTime * DifficultyIncrease) / 10)
	
	if(TimePassed > Difficulty):
		TimePassed = 0
		Spawn()


# Returns true if a raider was spawned
func Spawn():
	var Spawners = get_tree().get_nodes_in_group("Spawners")
	var invisibleSpawners = []
	for spawner in Spawners:
		if !spawner.Visible():
			invisibleSpawners.push_back(spawner)
	
	if invisibleSpawners.empty():
		return false
	
	invisibleSpawners[randi() % invisibleSpawners.size()].Spawn()
	
	return true
