
extends Node2D

var main_node = null

var pressed

func _ready():
	pressed = false
	get_viewport().warp_mouse(Vector2(Globals.get("display/width")/2, Globals.get("display/height")/2))
	main_node = get_tree().get_root().get_node("main")
	get_node("button-g").off_button()
	get_node("AnimationPlayer").seek(0)

func mouse_button(button):
	#Click count
	main_node.click()
	if (button.get_name() == "button-g"):
		button.off_button()
		main_node.right_action_with_delay(1)
	else:
		main_node.bad_action()


func _on_Area2D_input_event( viewport, event, shape_idx ):
	if (not pressed and event.type == InputEvent.MOUSE_BUTTON and event.is_pressed() and event.button_index == BUTTON_LEFT):
		pressed = true
		get_node("AnimationPlayer").play("run_not")
		yield(get_node("AnimationPlayer"), "finished")
		get_node("button-g").on_button()


func mouse_draging(button, offset_clic):
	pass
