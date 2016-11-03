adding/removing
addEventFilter: aFilter
	aFilter onInstalledIn: self owner.
	self filters add: aFilter.
	