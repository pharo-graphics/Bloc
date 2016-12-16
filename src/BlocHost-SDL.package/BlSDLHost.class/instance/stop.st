api
stop
	EventLoopProcess ifNotNil:[EventLoopProcess terminate].
	SDL2 quit.
	super stop