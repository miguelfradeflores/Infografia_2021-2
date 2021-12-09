extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
signal power2
signal power4

func _ready():
	hide()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func start(pos):
	position = pos
	scale.x = 1
	speed = 200
	show()


func power1():
	$power1.play()
	print("grande")
	scale.x += 0.2

func power2():
	$power2.play()
	print("ballspeed")
	emit_signal("power2")

func power3():
	$power3.play()
	print("speed")
	speed *= 1.2

func power4():
	$power4.play()
	print("ballminusSpeed")
	emit_signal("power4")
