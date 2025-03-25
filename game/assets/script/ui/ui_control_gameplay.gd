extends Control


@onready var ui_health = $"../control_2d_ui/heart_animation"
func _ready() -> void:
	ui_health.play("heart_"+ str(auto_main_autoload_script.player_health))
	$"..".show()
	pass

func _process(delta: float) -> void:
	#print(str(auto_main_autoload_script.player_data["health"]))
	ui_health.play("heart_"+ str(auto_main_autoload_script.player_health))
	#$DialogueBox.start("intro1")
	pass
