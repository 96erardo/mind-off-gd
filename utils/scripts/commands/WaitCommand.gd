class_name WaitCommand extends Command

var m_scene: Scene
var m_value: float

func _init(scene: Scene, value: float) -> void:
	m_scene = scene;
	m_value = value;
	
static func from_step (scene: Scene, step: WaitStep) -> Command:
	return WaitCommand.new(scene, step.value);
	
func execute():
	await m_scene.wait(m_value)
