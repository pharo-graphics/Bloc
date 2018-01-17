api - adding/removing
removeEventFilter: aFilter

	filters remove: aFilter.
	"free memory as soon as we got rid of all event filters"
	filters isEmpty
		ifTrue: [ filters := nil ].
	
	self hasOwner
		ifTrue: [ aFilter onUninstalledIn: self owner ]