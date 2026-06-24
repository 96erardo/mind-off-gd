extends Control

var decision_made = false

func _ready() -> void:
	$AnimationPlayer.play("Zoom Out")
	
func _process(delta: float) -> void:
	if decision_made == false:
		if Input.is_action_pressed("menu"):
			decision_made = true
			
			Transition.fade_to_scene("res://utils/scenes/menu.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Zoom Out":
		$Timer.start();

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("Fade_in_out")
