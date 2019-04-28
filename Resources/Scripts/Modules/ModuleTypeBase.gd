extends Object

class_name ModuleTypeBase

var activated = false

# Do not override these methods to create effect behaviour
func activateEffect():
	if not activated:
		activated = true
		start_effect()
		

func deactivateEffect():
	if activated:
		activated = false
		stop_effect()

# Override these methods instead
func start_effect():
	print("Start Base ModuleType Effect")

func stop_effect():
	print("Stop Base ModuleType Effect")