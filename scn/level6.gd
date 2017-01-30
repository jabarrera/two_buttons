
extends Node2D

const MINIMUM_BETWEEN_BUTTON = 20
const MAX_DISTANCE = 400

var main_node = null

var time_geiger = 1

func _ready():
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, Globals.get("display/height")/2))
	randomize()
	randomize_button_pos(get_node("button-g"))
	randomize_button_pos(get_node("button-r"))
	while (get_node("button-g").get_pos().distance_to(get_node("button-r").get_pos()) < MINIMUM_BETWEEN_BUTTON):
		randomize_button_pos(get_node("button-r"))
	main_node = get_tree().get_root().get_node("main")
	get_node("Timer").set_wait_time(time_geiger)
	#vanish buttons
	hide_buttons()
	set_process_input(true)
	
func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		var distance = get_node("button-g").get_pos().distance_to(get_viewport().get_mouse_pos())
		var new_time = (distance * time_geiger) / MAX_DISTANCE
		get_node("Timer").set_wait_time(max(0.05, new_time))
	

func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == "button-g"):
		button.off_button()
		show_buttons()
		main_node.right_action_with_delay(2)
	else:
		main_node.bad_action()
		
func mouse_draging(button, offset_clic):
	pass

func randomize_button_pos(button):
	var new_x = rand_range(0, Globals.get("display/width"))
	var new_y = rand_range(0, Globals.get("display/height"))
	var random_pos = Vector2(new_x, new_y)
	button.set_pos(random_pos)

func _on_Timer_timeout():
	get_tree().get_root().get_node("main/SamplePlayer").play("geiger")

func show_buttons():
	get_node("button-g/Area2D/Sprite").show()
	get_node("button-g/lights/ligths1").show()
	get_node("button-g/lights/ligths2").show()
	get_node("button-g/lights/ligths3").show()
	get_node("button-r/Area2D/Sprite").show()
	get_node("button-r/lights/ligths1").show()
	get_node("button-r/lights/ligths2").show()
	get_node("button-r/lights/ligths3").show()
	
func hide_buttons():
	get_node("button-g/Area2D/Sprite").hide()
	get_node("button-g/lights/ligths1").hide()
	get_node("button-g/lights/ligths2").hide()
	get_node("button-g/lights/ligths3").hide()
	get_node("button-r/Area2D/Sprite").hide()
	get_node("button-r/lights/ligths1").hide()
	get_node("button-r/lights/ligths2").hide()
	get_node("button-r/lights/ligths3").hide()