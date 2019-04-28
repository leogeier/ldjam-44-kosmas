extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
#var Position = Vector2(0,0)


var Path
var Goal

var line = null
export (int) var StandardSpeed = 200
var Speed = StandardSpeed
export (float) var BounceForce = 0.01
export (int) var BounceIntensity = 10000


# Called when the node enters the scene tree for the first time.
func _ready():
	var Path = null
	#$Sprite.play("Idle")
	pass # Replace with function body.

func CalculatePathLength(Path):
	var PathLength = 0
	for j in range(Path.size() - 1):
		PathLength = PathLength + (Path[j].distance_to(Path[j +1]))
	return PathLength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var GoalList = get_tree().get_nodes_in_group("RaiderTargets")
	#print("Goal list:", GoalList)
	var TempPath = null
	var PathDistance = INF
	
	for i in GoalList:
		#print(i)
		
		TempPath = get_parent().get_simple_path(position, i.position)
		#print(TempPath)
		#print(i, " Path length: ", CalculatePathLength(TempPath))
		PathDistance
		var TempDistance = CalculatePathLength(TempPath)
		if(PathDistance > TempDistance):
			Path = TempPath
			PathDistance = TempDistance
			#print("Shortest Path was ", PathDistance, " To object:", i)

		
	
	#Goal = get_parent().get_parent().get_node("Player")
	#print(Goal)
	#Path = get_parent().get_simple_path(position, Goal.position)

	if(Path.size() > 0):
		#print("Path Step: ", Path[0])
		#print("Path:", Path[0])
		#var DistanceToNext = global_position.distance_to(Path[0])
		var direction = (Path[1] - position).normalized()
		#AdaptSpeed()
		move_and_slide((direction )  * Speed)			#
		$AnimatedSprite.play("Running")
		if line != null:
			get_tree().get_root().remove_child(line)
		line = Line2D.new()
		line.points = Path
		get_tree().get_root().add_child(line)
	else:
		$AnimatedSprite.play("Idle")
		#Idle
	pass
	
func Kill():
	hide()
	#Drop Module
	
	
func AdaptSpeed():
	print("Overlapping Bodies: ", get_node("Area2D").get_overlapping_bodies().size())
	if(get_node("Area2D").get_overlapping_bodies().size() > 0):
		Speed = StandardSpeed * 3
	else:
		Speed = StandardSpeed
	
func GetNearestCollisionForce():
	var distance = INF
	var NearestBody = null
	var Force = Vector2(0,0)
	var Bodies = get_node("Area2D").get_overlapping_bodies()
	#print("Overlapping Bodies: ",Bodies)
	for i in Bodies:
		#print("Distance to overlapping: ", position.distance_to(i.position))
		#position.distance_to(i)
		var TempVector = (position - i.position) 
		if(TempVector.x < TempVector.y):
			TempVector.y = 0
		else:
			TempVector.x = 0
		#							Vector            *      (Distance 			/     Intensity)
		var CollisionVector = (TempVector * (position.distance_to(i.position) / BounceIntensity))
		Force = Force + (CollisionVector)
			
			
			
	return ((-1 * Force) )
	
	

	
	
	
	
	
	
	
	
	
	