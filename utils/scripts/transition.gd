extends CanvasLayer

@onready var anim = $AnimationPlayer

var next_scene_path: String
var next_scene_params: Dictionary

func fade_to_scene(scene_path: String, params: Dictionary = {}):
	_start_fade.call_deferred(scene_path, params);
	
func _start_fade (scene_path: String, params: Dictionary):
	next_scene_path = scene_path
	next_scene_params = params
	
	anim.play("Fade Out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade Out":
		var packed_scene = load(next_scene_path);
		var scene = packed_scene.instantiate();
		
		for key in next_scene_params.keys():
			scene[key] = next_scene_params[key];
		
		get_tree().current_scene.queue_free();
		get_tree().root.add_child(scene);
		get_tree().current_scene = scene;
		
		anim.play("Fade In")
