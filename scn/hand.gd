extends Sprite

const OFFSET_X = -30
const OFFSET_Y = 70
const FRAME_HAND_UP = 0
const FRAME_HAND_DOWN = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_offset(Vector2(OFFSET_X, OFFSET_Y))
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	update_cursor_position()

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.is_pressed()):
			get_tree().get_root().get_node("main/SamplePlayer").play("click_down")
			set_frame(FRAME_HAND_DOWN)
			get_tree().get_root().get_node("main").click()
		else:
			get_tree().get_root().get_node("main/SamplePlayer").play("click_up")
			set_frame(FRAME_HAND_UP)
	
	
func update_cursor_position():
	set_pos(get_viewport().get_mouse_pos())
	