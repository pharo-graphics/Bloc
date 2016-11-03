initialize-release
initialize
	super initialize.
	filters := BlHandlerRegistry new.
	handlers := BlHandlerRegistry new