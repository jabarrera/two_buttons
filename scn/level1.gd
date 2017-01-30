
extends Node2D

var main_node = null

func _ready():
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, Globals.get("display/height")/2))
	main_node = get_tree().get_root().get_node("main")

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
