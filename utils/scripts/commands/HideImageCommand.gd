class_name HideImageCommand extends Command

var m_scene: Scene;

func _init(scene: Scene) -> void:
	m_scene = scene;

static func from_step (scene: Scene, step: HideImageStep) -> Command:
	return HideImageCommand.new(scene)

func execute() -> void:
	await m_scene.imageViewer.slide_out()
