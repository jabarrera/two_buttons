
extends Node2D

export(String, "Green", "Red", "Blue") var color_modulate

const RED = Color(1, 0, 0, 1)
const GREEN = Color(0, 1, 0, 1)
const BLUE = Color(0, 0, 1, 1)
const NO_MODULATE = Color(1, 1, 1, 1)

var active
var have_the_mouse
var draging
var pos_where_clic
var offset_clic

func _ready():
	active = true
	have_the_mouse = false
	draging = false
	get_node("lights").hide()
	set_color_modulate()

func set_color_modulate():
	var color = GREEN
	if (color_modulate == "Red"):
		color = RED
	if (color_modulate == "Blue"):
		color = BLUE
	get_node("Area2D/Sprite").set_modulate(color)
	get_node("lights/ligths1").set_modulate(color)
	get_node("lights/ligths2").set_modulate(color)
	get_node("lights/ligths3").set_modulate(color)
	
func off_button():
	active = false
	get_node("Area2D/Sprite").set_modulate(NO_MODULATE)
	get_node("lights").hide()
	
func on_button():
	active = true
	set_color_modulate()

##############Connections
func _on_Area2D_mouse_enter():
	if (active):
		have_the_mouse = true
		get_node("lights").show()

func _on_Area2D_mouse_exit():
	have_the_mouse = false
	get_node("lights").hide()

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if (active):
		if (event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT):
			if (event.is_pressed()):
				draging = true
				pos_where_clic = event.pos
				offset_clic = Vector2()
				offset_clic.x = get_pos().x - pos_where_clic.x
				offset_clic.y = get_pos().y - pos_where_clic.y
			else:
				if (not mouse_has_moved(event)):
					get_tree().get_root().get_node("main/level").get_child(0).mouse_button(self)
				draging = false
				
		if (event.type == InputEvent.MOUSE_MOTION and draging):
			get_tree().get_root().get_node("main/level").get_child(0).mouse_draging(self, offset_clic)
			
func mouse_has_moved(event):
	if (event.pos == pos_where_clic):
		return false
	else:
		return true