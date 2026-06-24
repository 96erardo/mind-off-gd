class_name SlideImageCommand extends Command

var m_path: String;
var m_scene: Scene;

func _init(scene: Scene, path: String) -> void:
	m_scene = scene;
	m_path = path;

static func from_step (scene: Scene, step: SlideImageStep) -> Command:
	return SlideImageCommand.new(scene, step.path)

func execute() -> void:
	await m_scene.imageViewer.slide_in(m_path)
