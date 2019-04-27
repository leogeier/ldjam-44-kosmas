extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var SPEED = 150
var IsAlreadyKilled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play("Idle")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !IsAlreadyKilled:
		
	else:
		$Sprite.play("Death")
	pass
	
	func basicMovement():
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
		#keep track of last keystroke
		if !is_on_wall():
			lastKey = 1
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = false
		$Sprite.play("Run")
		#keep track of last keystroke
		if !is_on_wall():
			lastKey = 2


#extends KinematicBody2D
#
#
##constants
##Movement Speed
#
#const UP = Vector2(0,-1)
##JUMP strength
#export (int) var  JUMP = -250
##Gravity
#export(int) var GRAVITY = 15
##Walljumpstrength
#export (float) var WALLJUMPPAR = 1.2
##Lurpvalue
#export (float) var LURPVAL = 0.7
##gracevalue in frames
#export (int) var GRACEFACTOR = 5
##gracevalue for walljumps 
#export (int) var WALLGRACEFACTOR = 10
##make Boostvalue that will be added to counteract climbing
#export (int) var MAXWALLJUMPBOOST = 280
##will be subtracted from the walljumpboost each frame
#export (int) var WALLJUMPBOOSTITERATOR = 7
#const SLIDEFACTOR = 0
#
#
#
#
##motion vector
#var motion = Vector2(0,0)
##variabke for last keystroke
#var lastKey
##count walljumps
#var noJumps = 0
##variable for grace Period
#var grace = 0
#var wallgrace = 0
#var walljumpboost = 0
#var falling = false
#
#var IsAlreadyKilled = false
#
#
#
#func _ready():
#	get_node("Particles2D").set_emitting(false) 
#	$Sprite.play("Idle")
#	var afterDeathTimer = get_node("After Death Timer")
#	afterDeathTimer.connect("timeout", self, "onAfterDeathTimeout")
#	pass
#
#func onAfterDeathTimeout():
#	get_tree().reload_current_scene()
#
#func _physics_process(delta):
#	if !IsAlreadyKilled:
#		#Add gravity
#		motion.y += GRAVITY
#		#left and right and down movement tracking
#		basicMovement()
#
#		#Jump tracking
#		jumping()
#
#
#		#walljumptracking
#		wallJumpTracking()
#
#		#make walljumps non climbeable
#		climbProtection()
#
#		#call move and slide and update motion and grace values
#		#also add lurp
#		moveAndUpdate()
#
#		if isSquished():
#			kill()
#
#
#
#
#func get_name():
#	return "Player"			#Check for the Gem if Object is Player
#
#func basicMovement():
#	if Input.is_action_pressed("ui_right"):
#		motion.x = SPEED
#		$Sprite.flip_h = true
#		$Sprite.play("Run")
#		#keep track of last keystroke
#		if !is_on_wall():
#			lastKey = 1
#	elif Input.is_action_pressed("ui_left"):
#		motion.x = -SPEED
#		$Sprite.flip_h = false
#		$Sprite.play("Run")
#		#keep track of last keystroke
#		if !is_on_wall():
#			lastKey = 2
#
#	elif is_on_floor():
#		motion.x = 0
#		walljumpboost = 0
#		$Sprite.play("Idle")
#
#
#
#func jumping():
#	if is_on_floor() || grace < GRACEFACTOR:
#		if Input.is_action_just_pressed("ui_up"):
#			jumpSound()
#			motion.y = JUMP
#
#func wallJumpTracking():
#	if Input.is_action_pressed("ui_down"):
#		falling = true
#	if (is_on_wall() && !is_on_floor()) || wallgrace <= WALLGRACEFACTOR:
#
#		if is_on_wall():
#
#			if motion.y < 0:
#				$Sprite.play("Jump")
#
#				motion.y += SLIDEFACTOR
#			wallgrace = 0
#
#
#			if falling == true:
#				pass
#			elif motion.y >0 && (Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left")):
#				$Sprite.play("WallSlide")
#				motion.y =  motion.y*0.5
#		else:
#			wallgrace += 1
#
#		#make walljump by pressing up
#		if Input.is_action_just_pressed("ui_up"):
#			jumpSound()
#			#determine wall by last keystroke
#			if (lastKey == 1 && wallgrace == 0) || (lastKey == 2 && wallgrace != 0):
#				motion.y = WALLJUMPPAR*JUMP
#				walljumpboost = -MAXWALLJUMPBOOST
#				motion.x = 1
#				#JumptimerRight()
#			if (lastKey == 2 && wallgrace == 0) || (lastKey == 1 && wallgrace != 0):
#				motion.y = WALLJUMPPAR*JUMP
#				walljumpboost = MAXWALLJUMPBOOST
#				motion.x = -1
#				#JumptimerLeft()
#			wallgrace = WALLGRACEFACTOR+1
#
#func climbProtection():
#	if abs(walljumpboost) > WALLJUMPBOOSTITERATOR:
#
#		if walljumpboost > 0:
#			if motion.x <= 0:
#				motion.x += walljumpboost
#
#			walljumpboost -= WALLJUMPBOOSTITERATOR
#		if walljumpboost < 0:
#			if motion.x >= 0:
#				motion.x += walljumpboost
#
#			walljumpboost += WALLJUMPBOOSTITERATOR
#
#
#func moveAndUpdate():
#	#only update motion if character is on the ground 
#	var motiontmp = move_and_slide(motion,UP)
#	if is_on_floor():
#		falling = false
#		motion = motiontmp
#		#reset jumpgrace if on floor
#		wallgrace = WALLGRACEFACTOR+1
#		grace = 0
#	else:
#		if !is_on_wall():
#			$Sprite.play("Jump")
#		motion.y = motiontmp.y
#		#otherwise increment it
#		grace += 1
#	if !is_on_wall():
#		motion.x = lerp(0,motion.x,LURPVAL)
#
#func kill():
#	if !IsAlreadyKilled:
#		IsAlreadyKilled = true
#		deathSound()
#		get_node("Particles2D").set_emitting(true) 
#		get_node("Particles2D").restart()
#		get_node("After Death Timer").start()
#	#get_tree().reload_current_scene()
#
#
#func jumpSound():
#	var random = String(randi()%10+1)
#	var path = "JumpSounds/JumpSound" + random
#	get_node(path).set_volume_db(-12.0) 
#	#print("Play sound: ", random)
#	get_node(path).play(0.000001)
#
#func deathSound():
#	var random = String(randi()%10+1)
#	var path = "DeathSounds/DeathSound" + random
#	get_node(path).set_volume_db(-12.0) 
#	#print("Play sound: ", random)
#	get_node(path).play(0.000001)
#
#func isSquished():
#	return ((get_node("LeftSquish").isOverlappingObjects()
#		and get_node("RightSquish").isOverlappingObjects())
#		or (get_node("TopSquish").isOverlappingObjects()
#		and get_node("BottomSquish").isOverlappingObjects()))