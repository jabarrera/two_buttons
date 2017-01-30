
extends Node2D

const NEAR_DISTANCE = 150
const FAR_DISTANCE = 500

var MIDDLE_SCREEN_X = null
var MIDDLE_SCREEN_Y = null
var main_node = null
var pos_button_g = Vector2(250, 316)

var first_time = true

func _ready():
	get_node("button-g").active = false
	MIDDLE_SCREEN_X = (Globals.get("display/width") / 2)
	MIDDLE_SCREEN_Y = (Globals.get("display/height") / 2)
	get_viewport().warp_mouse(Vector2(MIDDLE_SCREEN_X, MIDDLE_SCREEN_Y))
	main_node = get_tree().get_root().get_node("main")
	randomize()
	set_fixed_process(true)

		
func _fixed_process(delta):
	if (first_time):
		get_node("button-g").set_pos(pos_button_g)
		yield(get_tree(), "idle_frame")
		first_time = false
		get_node("button-g").active = true
	else:
		if (not get_node("button-r").have_the_mouse):
			dark_green_button()
			var distancia = distance_mouse_button()
			if (distancia < NEAR_DISTANCE):
				var new_pos = Vector2(get_new_x(), get_new_y())
				if (get_node("button-r").get_pos().distance_to(new_pos) < NEAR_DISTANCE):
					if (randi()):
						new_pos.y = get_node("button-r").get_pos().y + 100
					else:
						new_pos.y = get_node("button-r").get_pos().y - 100
				get_node("button-g").set_pos(new_pos)
		else:
			revail_real_green_button()
	
func revail_real_green_button():
	get_node("button-r").color_modulate = "Green"
	get_node("button-r").set_color_modulate()
	get_node("button-g").color_modulate = "Red"
	get_node("button-g").set_color_modulate()

func dark_green_button():
	if (get_node("button-g").color_modulate == "Red"):
		get_node("button-r").color_modulate = "Red"
		get_node("button-r").set_color_modulate()
		get_node("button-g").color_modulate = "Green"
		get_node("button-g").set_color_modulate()

func get_new_x():
	var x
	if (get_viewport().get_mouse_pos().x < MIDDLE_SCREEN_X):
		x = rand_range(MIDDLE_SCREEN_X, Globals.get("display/width"))
	else:
		x = rand_range(0, MIDDLE_SCREEN_X)
	return x

func get_new_y():
	var y
	if (get_viewport().get_mouse_pos().y < MIDDLE_SCREEN_Y):
		y = rand_range(MIDDLE_SCREEN_Y, Globals.get("display/height"))
	else:
		y = rand_range(0, MIDDLE_SCREEN_Y)
	return y


func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == "button-r"):
		button.off_button()
		main_node.right_action_with_delay(1)
	else:
		main_node.bad_action()
		
func distance_mouse_button():
	var distance = get_node("button-g").get_pos().distance_to(get_viewport().get_mouse_pos())
	return distance
	
func mouse_draging(button, offset_clic):
	pass
