extends Object

class_name ModuleQueue

var modules = []

func push_module(module: ModuleTypeBase):
	modules.push_back(module)

func pop_module():
	return modules.pop_front()

func is_empty():
	return modules.empty()