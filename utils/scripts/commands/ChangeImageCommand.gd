class_name ChangeImageCommand extends Command

var m_path: String;
var m_scene: Scene;

func _init(scene: Scene, path: String) -> void:
	m_scene = scene;
	m_path = path;

static func from_step (scene: Scene, step: ChangeImageStep) -> Command:
	return ChangeImageCommand.new(scene, step.path)

func execute() -> void:
	await m_scene.imageViewer.change(m_path)
