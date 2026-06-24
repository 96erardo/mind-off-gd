class_name PlayCommand extends Command

var m_scene: Scene;

func _init(scene: Scene) -> void:
	m_scene = scene;

static func from_step (scene: Scene, step: CutSceneStep) -> Command:
	return PlayCommand.new(scene)

func execute () -> void:
	await m_scene.start()
