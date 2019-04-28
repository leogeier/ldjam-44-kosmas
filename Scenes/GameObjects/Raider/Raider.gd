extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
#var Position = Vector2(0,0)


var Path
var Goal

var line = null
export (int) var StandardSpeed = 200
export (int) var CarrySpeed = 120
var TempSpeed
var Speed = StandardSpeed
var TimeEffect = 0
var SpeedFactor = 1

var CarryingModule = false

export (float) var BounceForce = 0.01
export (int) var BounceIntensity = 10000


# Called when the node enters the scene tree for the first time.
func _ready():
	var Path = null
	#show_on_top = true
	#$Sprite.play("Idle")
	pass # Replace with function body.

func CalculatePathLength(Path):
	var PathLength = 0
	for j in range(Path.size() - 1):
		PathLength = PathLength + (Path[j].distance_to(Path[j +1]))
	return PathLength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):


	if(CarryingModule != null):
		Speed = CarrySpeed * SpeedFactor
		$AnimatedSprite.play("Idle")
		var DistanceVector = position - get_tree().get_nodes_in_group("players")[0].position
		var direction = (DistanceVector).normalized()
	else:
		Speed = StandardSpeed * SpeedFactor
		var GoalList = get_tree().get_nodes_in_group("RaiderTargets")
		#print("Goal list:", GoalList)
		var TempPath = null
		var PathDistance = INF
		
		for i in GoalList:
			TempPath = get_tree().get_nodes_in_group("Navigation2D")[0].get_simple_path(position, i.position)
			PathDistance
			var TempDistance = CalculatePathLength(TempPath)
			if(PathDistance > TempDistance):
				Path = TempPath
				PathDistance = TempDistance

		if(Path.size() > 0):
			var direction = (Path[1] - position).normalized()
			#AdaptSpeed()
			$AnimatedSprite.play("Running")
			if line != null:
				get_tree().get_root().remove_child(line)
			line = Line2D.new()
			line.points = Path
			get_tree().get_root().add_child(line)
		else:
			$AnimatedSprite.play("Idle")
			#Idle
	move_and_slide((direction )  * Speed)
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
	
	

#Time for how long the Effect is active
#Factor changes Speed, 0.5 = half speed, 0 = stun
func SlowFor(Time, Factor):
	if(Speed < (StandardSpeed * Factor)):
		return
	SpeedFactor = Factor
	TimeEffect = Time
	return
	
	
	
	
	
	
	
	