adding/removing
removeEventFilters
	self filters
		do: [ :each | 
			self filters remove: each.
			each onUninstalledIn: self owner ]