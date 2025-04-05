extends Node

func _ready() -> void:
	timer_helper(1.0, timer1)
	timer_helper(2.0, timer2)
	timer_helper(3.0, timer3)
	timer_helper(4.0, timer4)
	timer_helper(5.0, timer5)
	timer_helper(5.5, timer6)

func timer_helper(delay, callback):
	var t = Timer.new()
	t.wait_time = delay
	t.one_shot = true
	t.connect("timeout", callback)
	add_child(t)
	t.start()

func timer1():
	SignalBus.emit_signal("new_energy_level", 50)

func timer2():
	SignalBus.emit_signal("new_energy_level", 25)

func timer3():
	SignalBus.emit_signal("add_task", "baz")
	SignalBus.emit_signal("add_task", "foo foo foo")
	SignalBus.emit_signal("add_task", "bar")

func timer4():
	SignalBus.emit_signal("complete_task", "foo foo foo")

func timer5():
	SignalBus.emit_signal("clear_completed_tasks")

func timer6():
	SignalBus.emit_signal("add_task", "1 more?!")
