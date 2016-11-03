adding/removing
removeEventFilter: aFilter
	self filters remove: aFilter.
	aFilter onUninstalledIn: self owner