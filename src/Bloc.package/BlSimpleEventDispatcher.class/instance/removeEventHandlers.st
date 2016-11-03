adding/removing
removeEventHandlers
	self handlers
		do: [ :each | 
			self handlers remove: each.
			each onUninstalledIn: self owner ]