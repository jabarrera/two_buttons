
extends Node2D

var main_node = null

const button_b_texture = preload("res://art/button-b.png")
const button_y_texture = preload("res://art/button-y.png")
const l1_b_texture = preload("res://art/l1_b.png")
const l2_b_texture = preload("res://art/l2_b.png")
const l3_b_texture = preload("res://art/l3_b.png")

const DISTANCE_MUTATION = 5

func _ready():
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, Globals.get("display/height")/2))
	main_node = get_tree().get_root().get_node("main")
	get_node("button-r/Area2D/Sprite").set_modulate(Color(1, 1, 1, 1))
	get_node("button-r/Area2D/Sprite").set_texture(button_b_texture)
	get_node("button-r/lights/ligths1").set_modulate(Color(1, 1, 1, 1))
	get_node("button-r/lights/ligths1").set_texture(l1_b_texture)
	get_node("button-r/lights/ligths2").set_modulate(Color(1, 1, 1, 1))
	get_node("button-r/lights/ligths2").set_texture(l2_b_texture)
	get_node("button-r/lights/ligths3").set_modulate(Color(1, 1, 1, 1))
	get_node("button-r/lights/ligths3").set_texture(l3_b_texture)
	
	get_node("button-g/Area2D/Sprite").set_texture(button_y_texture)
	get_node("button-g/Area2D/Sprite").set_modulate(Color(1, 1, 1, 1))
	get_node("button-g/lights/ligths1").set_modulate(Color(1, 1, 0, 1))
	get_node("button-g/lights/ligths2").set_modulate(Color(1, 1, 0, 1))
	get_node("button-g/lights/ligths3").set_modulate(Color(1, 1, 0, 1))
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (mutation() and get_node("button-g/Area2D").is_pickable()):
		get_node("button-g/Area2D").set_pickable(false)
	else:
		if (not mutation() and not get_node("button-g/Area2D").is_pickable()):
			get_node("button-g/Area2D").set_pickable(true)
	
func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == "button-r" and mutation()):
		button.off_button()
		main_node.right_action_with_delay(1)
	else:
		main_node.bad_action()

func mouse_draging(button, offset_clic):
	if (button.get_name() == "button-r"):
		button.set_pos(get_viewport().get_mouse_pos() + offset_clic)
	
func mutation():
	if (get_node("button-r").get_pos().distance_to(get_node("button-g").get_pos()) < DISTANCE_MUTATION):
		return true
	else:
		return false