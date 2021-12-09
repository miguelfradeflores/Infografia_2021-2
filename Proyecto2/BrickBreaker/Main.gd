extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var numberBricks


# Called when the node enters the scene tree for the first time.
func _ready():
	$pause.hide()
	$menu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ball_hit():
	stop_sounds()
	$Paddle.start($PaddlePosition.position)
	$ball.start($BallPosition.position)
	$Paddle.hide()
	$ball.hide()
	$pause.hide()
	$menu.hide()
	$ball.velocity.x = 0
	$ball.velocity.y = 0
	if numberBricks <= 0:
		$gameOver.play()
		$HUD.show_win()
	elif numberBricks == 100:
		$HUD.show_menu()
	else:
		$win.play()
		$HUD.show_game_over()
	get_tree().call_group("brick", "noshowBricks")
	get_tree().call_group("brick2", "noshowBricks")
	get_tree().call_group("brick3", "noshowBricks")



func _on_ball_brickDestroyed_score():
	numberBricks -= 1
	print(numberBricks)
	if numberBricks <= 0:
		_on_ball_hit()


func _on_start_level1():
	stop_sounds()
	$game.play()
	$Paddle.start($PaddlePosition.position)
	$ball.start($BallPosition.position)
	numberBricks = $level1.get_child_count()
	get_tree().call_group("brick", "showBricks")
	get_tree().call_group("brick", "animationGreen")
	$Paddle.show()
	$level1.show()
	$pause.show()
	$menu.show()
	$ball.velocity.x = 200
	$ball.velocity.y = 200


func _on_start_level2():
	stop_sounds()
	$game.play()
	$Paddle.start($PaddlePosition.position)
	$ball.start($BallPosition.position)
	numberBricks = $level2.get_child_count()
	get_tree().call_group("brick2", "showBricks")
	get_tree().call_group("brick2", "animationBlue")
	$Paddle.show()
	$level2.show()
	$ball.velocity.x = 200
	$ball.velocity.y = 200
	$pause.show()
	$menu.show()

func _on_start_level3():
	stop_sounds()
	$game.play()
	$Paddle.start($PaddlePosition.position)
	$ball.start($BallPosition.position)
	numberBricks = $level3.get_child_count()
	get_tree().call_group("brick3", "showBricks")
	get_tree().call_group("brick3", "animationRed")
	$Paddle.show()
	$level3.show()
	$ball.velocity.x = 200
	$ball.velocity.y = 200
	$pause.show()
	$menu.show()

func _on_power2():
	$ball.velocity.x *= 1.2
	$ball.velocity.y *= 1.2


func _on_Paddle_power4():
	$ball.velocity.x *= 0.9
	$ball.velocity.y *= 0.9


func _on_pause_pressed():
	stop_sounds()
	$btn.play()
	get_tree().paused = true
	$PopupPause.show()



func _on_unpause_pressed():
	stop_sounds()
	$btn.play()
	get_tree().paused = false
	$PopupPause.hide()



func _on_home_pressed():
	stop_sounds()
	numberBricks = 100
	$btn.play()
	_on_ball_hit()

func stop_sounds():
	$win.stop()
	$gameOver.stop()
	$btn.stop()
	$game.stop()
