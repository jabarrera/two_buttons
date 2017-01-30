
extends Node2D

const LIGHT_OFF = 0
const LIGHT_ON = 1

func _ready():
	get_node("tooltip").hide()
	set_process_input(true)

func _on_off_mouse_enter():
	get_node("tooltip/Timer").start()
	get_node("Sprite").set_frame(LIGHT_ON)
	
func _on_off_mouse_exit():
	get_node("tooltip/Timer").stop()
	get_node("tooltip").hide()
	get_node("Sprite").set_frame(LIGHT_OFF)

func _on_off_input_event( viewport, event, shape_idx ):
	if (event.type == InputEvent.MOUSE_BUTTON and
		event.button_index == BUTTON_LEFT and
		not event.is_pressed()):
			get_tree().quit()


func _on_Timer_timeout():
	get_node("tooltip").show()
