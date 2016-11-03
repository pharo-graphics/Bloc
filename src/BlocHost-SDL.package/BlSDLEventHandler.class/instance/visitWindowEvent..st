event handling
visitWindowEvent: windowEvent
	
	windowEvent event = SDL_WINDOWEVENT_EXPOSED ifTrue: [
		^ BlWindowExposeEvent new
			timestamp: Time millisecondClockValue.
	].
	windowEvent event = SDL_WINDOWEVENT_CLOSE ifTrue: [ 
		^ BlWindowCloseEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MOVED ifTrue: [ 
		^ BlWindowMoveEvent new
			timestamp: Time millisecondClockValue;
			position: self hostSpace position
	].
	windowEvent event = SDL_WINDOWEVENT_RESIZED ifTrue: [ 
		^ BlWindowResizeEvent new
			extent: windowEvent data1 @ windowEvent data2;
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_ENTER ifTrue: [ 
		^ BlWindowMouseEnterEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_LEAVE ifTrue: [ 
		^ BlWindowMouseLeaveEvent new
			timestamp: Time millisecondClockValue;
			yourself
	].
	windowEvent event = SDL_WINDOWEVENT_FOCUS_GAINED ifTrue: [ 
		^ BlWindowFocusInEvent new
			timestamp: Time millisecondClockValue;
			yourself
	].
	windowEvent event = SDL_WINDOWEVENT_FOCUS_LOST ifTrue: [ 
		^ BlWindowFocusOutEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MAXIMIZED ifTrue: [ 
		^ BlWindowMaximizedEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MINIMIZED ifTrue: [ 
		^ BlWindowMinimizedEvent new
			timestamp: Time millisecondClockValue
	].

^ BlWindowEvent new
	timestamp: Time millisecondClockValue