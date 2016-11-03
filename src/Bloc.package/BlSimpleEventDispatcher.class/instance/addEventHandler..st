adding/removing
addEventHandler: anHandler
	anHandler onInstalledIn: self owner.
	self handlers add: anHandler