adding/removing
removeEventHandler: anHandler
	self handlers remove: anHandler.
	anHandler onUninstalledIn: self owner