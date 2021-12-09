extends CanvasLayer

signal start_game
signal start_level1
signal start_level2
signal start_level3

func show_message(text):
	$Message.text = text
	$Message.show()


func show_game_over():
	show_message("Game Over")
	$Btn2.show()
	$Btn3.show()
	$Btn1.show()

func show_win():
	show_message("Winner")
	$Btn2.show()
	$Btn3.show()
	$Btn1.show()

func show_menu():
	show_message("Choose Level")
	$Btn2.show()
	$Btn3.show()
	$Btn1.show()

func _on_Button_1_pressed():
	$BtnSound.play()
	$Btn1.hide()
	$Btn2.hide()
	$Btn3.hide()
	$Message.hide()
	emit_signal("start_level1")


func _on_Btn2_pressed():
	$BtnSound.play()
	$Btn1.hide()
	$Btn2.hide()
	$Btn3.hide()
	$Message.hide()
	emit_signal("start_level2")


func _on_Btn3_pressed():
	$BtnSound.play()
	$Btn1.hide()
	$Btn2.hide()
	$Btn3.hide()
	$Message.hide()
	emit_signal("start_level3")
