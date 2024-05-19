extends Node2D


var Drawing : bool = true
var drawMoveLine : bool = false

@onready var MoveLine : Line2D = $MoveLine

var ShootingLineArray: Array[Line2D]  = []  # Array of all the shooting lines
var drawShootingLine : bool = false  # Flag for drawing a shooting line
var ShootingLineIndex : int = 0  # Index of the current shooting line

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(_delta):
	

	if Input.is_action_pressed("MouseLeft"):
		if drawMoveLine:
			MoveLine.add_point(get_local_mouse_position())
		
		if drawShootingLine:
			ShootingLineArray[ShootingLineIndex].add_point(get_local_mouse_position())

	if Input.is_action_just_released("MouseLeft"):
		if drawMoveLine:
			MoveLine.add_point(get_local_mouse_position())
			drawMoveLine = false

		if drawShootingLine:
			ShootingLineArray[ShootingLineIndex].add_point(get_local_mouse_position())
			drawShootingLine = false
			ShootingLineIndex += 1


func DrawMoveLine():
	MoveLine.clear_points()
	MoveLine.add_point(position)
	drawMoveLine = true
	MoveLine.visible = true


@onready var ShootingLine : Line2D = $ShootingLineExample

func DrawShootingLine():
	var temp = ShootingLine.duplicate()
	add_child(temp)
	ShootingLineArray.push_back(temp)
	drawShootingLine = true
	ShootingLineArray[ShootingLineIndex].visible = true



func ResetShootingLine():
	ShootingLineIndex = 0
	ShootingLineArray.clear()


signal ShootDataSignal(shootingPos : Array[Vector2], shootingAngle : Array[Vector2])

func sendShootingData():

	var ShootingPos : Array[Vector2] = []
	var ShootingAngle : Array[Vector2] = []

	ShootingPos.resize(ShootingLineArray.size())
	ShootingAngle.resize(ShootingLineArray.size())

	ShootingPos.fill(Vector2.ZERO)
	ShootingAngle.fill(Vector2.ZERO)

	for i in ShootingLineArray.size():
		ShootingPos[i] = global_position + (ShootingLineArray[i].points[0])
		ShootingAngle[i] = (ShootingLineArray[i].points[ShootingLineArray[i].points.size() - 1] - ShootingLineArray[i].points[0]).normalized()

	emit_signal("ShootDataSignal", ShootingPos, ShootingAngle)


func hideShootingLine():
	for i in ShootingLineArray.size():
		ShootingLineArray[i].visible = false
