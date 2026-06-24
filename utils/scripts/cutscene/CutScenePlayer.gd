class_name CutScenePlayer extends RefCounted

var cutscene: CutScene;
var scene: Scene;

func _init(path: String, s: Scene) -> void:
	_load_cutscene(path);
	scene = s
	
func _load_cutscene (path: String) -> void:
	cutscene = load(path);
	
func run () -> void: 
	for step in cutscene.steps:
		if scene.has_command(step.action):
			var command = scene.commands[step.action].from_step(scene, step);
			
			await command.execute();
