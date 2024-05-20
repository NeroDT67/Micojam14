extends CharacterBody2D




const SPEED = 300.0  # Speed of the character when moving
const JUMP_VELOCITY = -400.0  # Initial velocity when jumping

var AnimFlip : bool = false  # Animation flip flag
var moving : bool = false  # Moving flag

@onready var MoveLine : Line2D = $Lines/MoveLine  # Line for showing the character's path
var MoveLineIndex : int = 0  # Index of the current path line



var ShootingPos : Array[Vector2] = []  # Array of all the shooting positions
var ShootingAngle : Array[Vector2] = []  # Array of all the shooting angles

@onready var targetPosition : Vector2 = position  # Target position for the character to move to
@onready var startPosition : Vector2 = position  # Start position of the character

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")  # Gravity value

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D  # Character's animation sprite
@onready var  gunshot = $gunshot


	 

func _physics_process(delta):
	
	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	

	if moving :
		
		var direction = clampi(targetPosition.x - position.x, -1, 1)
		
		velocity.x = direction * SPEED
		
		#print("Position")
		#print(position.x)
		#print(position.y)
		#print("target")
		#print(targetPosition.x)
		#print(targetPosition.y)
		
		if position.x - targetPosition.x < 10:
			MoveLineIndex += 1
			calcutateTargetPosition()
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#print(targetPosition.y - startPosition.y)
	if is_on_floor() and (targetPosition.y - startPosition.y) < -20 and moving:
		velocity.y = JUMP_VELOCITY

	for i in range(ShootingPos.size()):
		
		if ShootingPos[i].distance_to(position) < 20:
			Shoot(ShootingPos[i], ShootingAngle[i])
			ShootingPos.remove_at(i)
			ShootingAngle.remove_at(i)
			break
			
	
	

	# animations
	
	if velocity.x != 0:
		if velocity.x > 0:
			AnimFlip = false
		else :
			AnimFlip = true
		
		anim.flip_h = AnimFlip
		
		anim.play("Run")
	else:
		anim.play("Idle")

	if sqrt(velocity.y * velocity.y) > 5:
		anim.play("Jump")
	
	
	move_and_slide()


signal disableShootingLine
signal sendShootingData
signal ResetShootingData

func startMoving():
	ShootingPos = []
	ShootingAngle = []
	MoveLine.visible = false
	emit_signal("disableShootingLine")
	emit_signal("sendShootingData")
	emit_signal("ResetShootingData")
	MoveLineIndex = 0
	startPosition = position
	calcutateTargetPosition()
	moving = true

	
func calcutateTargetPosition():
	if MoveLine.points.size() > MoveLineIndex:
		targetPosition = startPosition + MoveLine.points[MoveLineIndex] * 2
	else:
		moving = false

func SetShootingDetails(shootingPos : Array[Vector2], shootingAngle : Array[Vector2]):
	ShootingPos = shootingPos
	ShootingAngle = shootingAngle

func ShootingDetailsReset():
	ShootingPos = []
	ShootingAngle = []


var bullet = preload("res://GunsAndBullets/Bullet1.tscn")

func Shoot(pos : Vector2, angle : Vector2):
	var b = bullet.instantiate()
	gunshot.play()
	b.start(pos + angle*50, angle)
	get_tree().root.add_child(b)
	
func player():
	pass