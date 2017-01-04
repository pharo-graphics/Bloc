event handling
visitWindowEvent: windowEvent
	
	windowEvent event = SDL_WINDOWEVENT_EXPOSED ifTrue: [
		^ BlSpaceExposeEvent new
			timestamp: Time millisecondClockValue.
	].
	windowEvent event = SDL_WINDOWEVENT_CLOSE ifTrue: [ 
		^ BlSpaceCloseEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MOVED ifTrue: [ 
		^ BlSpaceMoveEvent new
			timestamp: Time millisecondClockValue;
			position: self hostSpace position
	].
	windowEvent event = SDL_WINDOWEVENT_RESIZED ifTrue: [ 
		^ BlSpaceResizeEvent new
			extent: windowEvent data1 @ windowEvent data2;
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_ENTER ifTrue: [ 
		^ BlSpaceMouseEnterEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_LEAVE ifTrue: [ 
		^ BlSpaceMouseLeaveEvent new
			timestamp: Time millisecondClockValue;
			yourself
	].
	windowEvent event = SDL_WINDOWEVENT_FOCUS_GAINED ifTrue: [ 
		^ BlSpaceFocusInEvent new
			timestamp: Time millisecondClockValue;
			yourself
	].
	windowEvent event = SDL_WINDOWEVENT_FOCUS_LOST ifTrue: [ 
		^ BlSpaceFocusOutEvent new
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MAXIMIZED ifTrue: [ 
		^ BlSpaceMaximizedEvent new
			extent: hostSpace windowExtent;
			timestamp: Time millisecondClockValue
	].
	windowEvent event = SDL_WINDOWEVENT_MINIMIZED ifTrue: [ 
		^ BlSpaceMinimizedEvent new
			extent: hostSpace windowExtent;
			timestamp: Time millisecondClockValue
	].

^ BlSpaceEvent new
	timestamp: Time millisecondClockValue