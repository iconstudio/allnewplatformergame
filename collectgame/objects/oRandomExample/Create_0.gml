randomize()
TestEngine = new MersenneTwister()

repeat 1000
	show_debug_message(TestEngine.make_integer(50))

repeat 1000
	show_debug_message(TestEngine.make_float(0.5))

repeat 1000
	show_debug_message(TestEngine.make_boolean())
