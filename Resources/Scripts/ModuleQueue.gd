extends Object

var Module = preload("res://Scenes/GameObjects/Module/Module.tscn")

class_name ModuleQueue

var modules = []

func push_module_type(module: ModuleTypeBase):
	modules.push_back(module)

func pop_module_type():
	return modules.pop_front()

func pop_module():
	var module = Module.instance()
	module.set_module_type(pop_module_type())
	return module

func is_empty():
	return modules.empty()