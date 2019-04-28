extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
#var Position = Vector2(0,0)

var Module = preload("res://Scenes/GameObjects/Module/Module.tscn")


var Path
var Goal

var line = null
export (bool) var ShowLine = false
export (int) var StandardSpeed = 70
export (int) var CarrySpeed = 40
var TempSpeed
var Speed = StandardSpeed
var TimeEffect = 0
var SpeedFactor = 1

var CarryingModule = null


export (float) var BounceForce = 0.01
export (int) var BounceIntensity = 10000


# Called when the node enters the scene tree for the first time.
func _ready():
	var Path = null
	add_to_group("enemy")
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
	
	if Input.is_action_just_pressed("ui_accept"):
		Kill()
	for i in get_node("Area2D").get_overlapping_bodies():
		if (i.is_in_group("RaiderTargets")):		# && (CarryingModule == null)
			if(i.is_collectable()):
				if(CarryingModule == null):
					CarryingModule = i.steal()
					print(CarryingModule)
				break
			else:
				print(i)
				Kill()
	
	var direction
	if(CarryingModule != null):		#Running Away:
		Speed = CarrySpeed * SpeedFactor
		#$AnimatedSprite.play("Running")
		var DistanceVector = position - get_tree().get_nodes_in_group("players")[0].position
		direction = (DistanceVector).normalized()
		ShowLine = false
	else:							#Running For:
		Speed = StandardSpeed * SpeedFactor
		var GoalList = get_tree().get_nodes_in_group("RaiderTargets")
		#print("Goal list:", GoalList)
		var TempPath = null
		var PathDistance = INF
		var ItemGoal 
		
		for i in GoalList:
			TempPath = get_tree().get_nodes_in_group("Navigation2D")[0].get_simple_path(position, i.position)
			#PathDistance
			var TempDistance = CalculatePathLength(TempPath)
			if Input.is_action_just_pressed("ui_cancel"):
				print(i.name, " Position: ", i.position, " with Distance: ", TempDistance)
			#print(i, " Item Distance: ",TempDistance)
			if((PathDistance > TempDistance) && (i.is_collectable())):
				Path = TempPath
				PathDistance = TempDistance
				ItemGoal = i
		#print("closest Item:",ItemGoal)

		if(Path.size() > 0):
			direction = (Path[1] - position).normalized()
	if(ShowLine):
		get_tree().get_root().remove_child(line)
		line = Line2D.new()
		line.points = Path
		get_tree().get_root().add_child(line)
	AnimationSelector(direction)
	move_and_slide((direction )  * Speed)
	
	pass
	

func AnimationSelector(direction):
	if(CarryingModule == null):
		if(direction.abs().x > direction.abs().y):
			$AnimatedSprite.play("RunningSide")
			$AnimatedSprite.set_flip_h(true)
			if(direction.x > 0):
				$AnimatedSprite.set_flip_h(false)
		else:
			$AnimatedSprite.play("RunningBack")
			if(direction.y > 0):
				$AnimatedSprite.play("RunningFront")
	else:
		if(direction.abs().x > direction.abs().y):
			$AnimatedSprite.play("RunningSidePack")
			$AnimatedSprite.set_flip_h(true)
			if(direction.x > 0):
				$AnimatedSprite.set_flip_h(false)
		else:
			$AnimatedSprite.play("RunningBackPack")
			if(direction.y > 0):
				$AnimatedSprite.play("RunningFrontPack")
		
	
func Kill():
	print("kill")
	if(CarryingModule != null):
		var droppedModule = Module.instance()
		droppedModule.set_module_type(CarryingModule)
		get_tree().get_root().add_child(droppedModule)
		droppedModule.position = global_position
	hide()
	queue_free()

	
	
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
	if(SpeedFactor < Factor):
		
		return
	SpeedFactor = Factor
	TimeEffect = Time
	return


	
	
	
	
	
	
	
	