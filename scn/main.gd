
extends Node2D

var levels = ["level1", "level2", "level3", "level4", "level5", "level6", "level7", "level8", "end_credits"]
var currentLevel = 1
var numClicks = 0
var playing


func _ready():
	load_level(currentLevel)
	set_process_input(true)
	
func _input(event):
	if (event.type == InputEvent.KEY):
		if (event.is_pressed() and event.scancode == KEY_F):
			if (not OS.is_window_fullscreen()):
				OS.set_window_fullscreen(true)
			else:
				OS.set_window_fullscreen(false)

func load_level(numLevel):
	if (currentLevel < 1 or currentLevel > levels.size()): return
	if (get_node("level").get_child_count() != 0):
		get_node("level").get_child(0).queue_free()
		get_node("level").remove_child(get_node("level").get_child(0))
	var level = load("res://scn/" + levels[numLevel-1] + ".tscn")
	var level_instance = level.instance()
	get_node("level").add_child(level_instance)
	

func right_action():
	get_node("SamplePlayer").play("wink")
	currentLevel += 1
	load_level(currentLevel)

func right_action_with_delay(time):
	get_node("SamplePlayer").play("wink")
	if (time > 0):
		get_node("waiter").set_wait_time(time)
		get_node("waiter").start()
		yield(get_node("waiter"), "timeout")
	currentLevel += 1
	load_level(currentLevel)

func bad_action():
	get_node("SamplePlayer").play("button_error")

func reset_game():
	bad_action()
	currentLevel = 1
	load_level(currentLevel)

func click():
	numClicks += 1