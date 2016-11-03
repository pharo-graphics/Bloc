visiting window
visitWindowExposeEvent: anEvent
	self flag: 'ToDo: Make dirty the exposed area.'.
	window renderNeeded.
	^ nil