extends Control

var starting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade_in_out");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("enter") && starting == false:
		starting = true
		
		Transition.fade_to_scene(
			"res://office/scenes/office_starting.tscn",
			{ "path": "res://utils/scripts/cutscene/start.tres" }
		)
