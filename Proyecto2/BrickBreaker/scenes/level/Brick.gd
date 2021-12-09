extends Node2D

signal power
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var brick_live = 2

var gravity = Vector2(0, -100)  # gravity force
var velocity = Vector2()  # the area's velocity
var power
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	hide()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$KinematicBody2D/CollisionShape2D.set_deferred("disabled", true)
	$powerBody/CollisionShape2D.set_deferred("disabled", true)
	$powerBody.hide()


func _process(delta):
	velocity += gravity * delta 


func showBricks():
	show()
	collisonBricks()
	$KinematicBody2D/AnimatedSprite.frame = 0
	brick_live = 2

func noshowBricks():
	hide()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$KinematicBody2D/CollisionShape2D.set_deferred("disabled", true)
	$powerBody/CollisionShape2D.set_deferred("disabled", true)

func collisonBricks():
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$KinematicBody2D/CollisionShape2D.set_deferred("disabled", false)
	$KinematicBody2D/AnimatedSprite.show()


func _on_ball_body_bricked(body):
	if body.is_in_group("ball"):
		if brick_live == 1:

			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			$KinematicBody2D/CollisionShape2D.set_deferred("disabled", true)
			$KinematicBody2D/AnimatedSprite.hide()
			get_tree().call_group("ball", "brick_destroyed")
			if (randi() % 100) % 2 == 0:
				power = randi() % 4
				$powerBody/AnimatedSprite.frame = power
				$powerBody.show()
				$powerBody/CollisionShape2D.set_deferred("disabled", false)
				$powerBody.gravity_scale = 2
		else:
			$KinematicBody2D/AnimatedSprite.frame = 1
		brick_live -= 1


func _on_powerBody_body_entered(body):
	if body.is_in_group("paddle"):
		$powerBody.gravity_scale = 0
		$powerBody.position = $Position2D.position
		$powerBody/AnimatedSprite.hide()
		$powerBody/CollisionShape2D.set_deferred("disabled", true)
		if $powerBody/AnimatedSprite.frame == 0:
			body.power1()
		elif $powerBody/AnimatedSprite.frame == 1:
			body.power2()
		elif $powerBody/AnimatedSprite.frame == 2:
			body.power3()
		else:
			body.power4()


func animationGreen():
	$KinematicBody2D/AnimatedSprite.animation = "brickGreen"

func animationBlue():
	$KinematicBody2D/AnimatedSprite.animation = "brickRed"

func animationRed():
	$KinematicBody2D/AnimatedSprite.animation = "brickBlue"
