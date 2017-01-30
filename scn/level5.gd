
extends Node2D

const SPEED_CLOSING = 5
const SCREEN_Y_OFFSET = 20

var acceleration
var main_node = null
var condition_ok
var darkness
var draging
var offset_clic

var MIDDLE_SCREEN_Y
var cont = 0

func _ready():
	condition_ok = false
	acceleration = 0
	darkness = true
	draging = false
	MIDDLE_SCREEN_Y = Globals.get("display/height")/2
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, MIDDLE_SCREEN_Y))
	main_node = get_tree().get_root().get_node("main")
	get_node("button-g/Area2D").set_pickable(false)
	get_node("button-r/Area2D").set_pickable(false)
	set_fixed_process(true)

func _fixed_process(delta):
	if (can_move_darkness()):
		var new_x = get_node("Area2D").get_pos().x
		var new_y
		if (get_node("Area2D").get_pos().y > (0-MIDDLE_SCREEN_Y)):
			new_y = get_node("Area2D").get_pos().y + SPEED_CLOSING + acceleration * delta
		else:
			new_y = get_node("Area2D").get_pos().y - SPEED_CLOSING - acceleration * delta
		get_node("Area2D").set_pos(Vector2(new_x, min(0, new_y)))
		acceleration += 50
	
	if (get_node("Area2D").get_pos().y >= 0 and acceleration != 0):
		acceleration = 0
	
	if (not condition_ok and (get_node("Area2D").get_pos().y < (0 - Globals.get("display/height") + SCREEN_Y_OFFSET))):
		condition_ok = true
		get_node("button-g/Area2D").set_pickable(true)
		get_node("button-r/Area2D").set_pickable(true)
		get_node("Label").set_text("Veil of light")
		get_node("Label").add_color_override("font_color", Color(0, 0, 0))

func can_move_darkness():
	return not draging and get_node("Area2D").get_pos().y < 0 and (get_node("Area2D").get_pos().y > 0 - Globals.get("display/height"))

func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == "button-g"):
		button.off_button()
		main_node.right_action_with_delay(1)
	else:
		main_node.bad_action()
		
func mouse_draging(button, offset_clic):
	pass

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if (event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT):
		if (event.is_pressed()):
			draging = true
			var pos_where_clic = event.pos
			offset_clic = Vector2()
			offset_clic.x = get_node("Area2D/darkness").get_pos().x - pos_where_clic.x
			offset_clic.y = get_node("Area2D/darkness").get_pos().y - pos_where_clic.y
		else:
			draging = false
				
	if (event.type == InputEvent.MOUSE_MOTION and draging):
		move_darkness(event.relative_x, event.relative_y)

func move_darkness(new_mouse_x, new_mouse_y):
	var x = get_node("Area2D").get_pos().x
	var y = get_node("Area2D").get_pos().y + min(0, new_mouse_y)
	var new_pos = Vector2(x, y)
	get_node("Area2D").set_pos(new_pos)
