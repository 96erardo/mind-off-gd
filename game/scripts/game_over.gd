extends Control

var decision_made = false;

func _ready() -> void: 
	var datetime: Dictionary = Time.get_datetime_dict_from_system()
	
	$Description.text = (
		"Pong is a game invented in 1972.\n" +
		"We are in big " + str(datetime.year) + " and you just lost bro.\n" +
		"Think about that."
	)

func _process(delta: float) -> void:
	if decision_made == false:
		if Input.is_action_pressed("retry"):
			decision_made = true
			
			Transition.fade_to_scene(
				"res://game/scenes/main.tscn", 
				{ "path": "res://utils/scripts/cutscene/during.tres" }
			)
		elif Input.is_action_pressed("menu"):
			decision_made = true
			
			Transition.fade_to_scene("res://utils/scenes/menu.tscn")
