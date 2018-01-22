dnd handlers
dragEvent: anEvent	
	"For selection we want to handle only those drag events that began exactly
	on the elemen I attached to"
		
	self hasOrigin
		ifFalse: [ ^ super dragOverEvent: anEvent ].
	
	corner := anEvent position.	
	self computeSelectionArea.
		
	self selectionChanged