api
announceDeleted
    super announceDeleted.

	currentWindow
		ifNil: [ ^ self closeSpace ].

	(self hasOwner: currentWindow)
		ifTrue: [ ^ self ].

	currentWindow isCollapsed
		ifTrue: [ ^ self ].

   self closeSpace