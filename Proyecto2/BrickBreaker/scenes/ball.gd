extends KinematicBody2D


export var velocity = Vector2(200, 200)
var screen_size  

signal brickDestroyed
# Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, 0)
	screen_size = get_viewport_rect().size
	hide()

func brick_destroyed():
	emit_signal("brickDestroyed")


func _physics_process(delta):
	var collision_Info = move_and_collide(velocity * delta)
	
	if collision_Info:
		velocity = velocity.bounce(collision_Info.normal)
		$hit.play()
		if abs(velocity.x) < 500:
			$AnimatedSprite.frame = 0
		elif abs(velocity.x) < 1000:
			$AnimatedSprite.frame = 3
		elif abs(velocity.x) < 1500:
			$AnimatedSprite.frame = 1
		else:
			$AnimatedSprite.frame = 2
		
		if abs(velocity.x) < 2500:
			velocity.x *= 1.03
			velocity.y *= 1.03


func start(pos):
	$AnimatedSprite.frame = 0
	position = pos
	show()
