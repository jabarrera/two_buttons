
extends Node2D

var main_node = null

func _ready():
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, Globals.get("display/height")/2))
	main_node = get_tree().get_root().get_node("main")
	get_node("button-b").color_modulate = "Blue"
	get_node("button-b").set_color_modulate()

func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == "button-r"):
		button.off_button()
		main_node.right_action_with_delay(1)
	else:
		main_node.reset_game()
		
func mouse_draging(button, offset_clic):
	pass
