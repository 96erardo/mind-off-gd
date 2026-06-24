extends Scene

var path = ""
var cutscene: CutScenePlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	commands = {
		"move": MoveCommand,
		"turn": TurnCommand,
		"wait": WaitCommand,
		"talk": TalkCommand
	};
	
	cutscene = CutScenePlayer.new(path, self)
	
	await cutscene.run();
	
	Transition.fade_to_scene(
		"res://game/scenes/main.tscn", 
		{ "path": "res://utils/scripts/cutscene/during.tres" }
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;
