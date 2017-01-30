
extends Node2D

var main_node = null

var button_name_lucky

func _ready():
	randomize()
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, Globals.get("display/height")/2))
	main_node = get_tree().get_root().get_node("main")
	set_good_button()
	

func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == button_name_lucky):
		button.off_button()
		main_node.right_action_with_delay(1)
	else:
		main_node.bad_action()
		button.color_modulate = "Red"
		button.set_color_modulate()
		
func mouse_draging(button, offset_clic):
	pass

func set_good_button():
	var button_lucky = randi() % get_node("array").get_child_count()
	button_name_lucky = get_node("array").get_child(button_lucky).get_name()
	