extends Node2D

var text

func _ready():
	text = str("You reache the end of the game\n",
	"CONGRATULATION!\n\n",
	"You got it in ", str(floor(get_tree().get_root().get_node("main").numClicks / 2)) + " clics\n")
	get_node("end").set_text(text)
	get_node("AnimationPlayer").seek(0)
	

func _on_Timer_timeout():
	get_node("AnimationPlayer").play("scroll")

func finish_credits_scroll():
	get_node("end").hide()
	get_node("mask-up").hide()
	get_node("mask-down").hide()
	get_node("Node2D/credits").hide()
	get_node("AnimationPlayer").play("finish")
	