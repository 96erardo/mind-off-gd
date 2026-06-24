class_name CutSceneLoader extends RefCounted

func _init(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	var json = JSON.new()
	
	var success = json.parse(file.get_as_text())
	
	
