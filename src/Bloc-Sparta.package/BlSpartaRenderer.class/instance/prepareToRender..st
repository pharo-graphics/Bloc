renderer - rendering
prepareToRender: aSpace
	"I check if window extent changed since last rendering step and if yes, recreate resources"

	(session == Smalltalk session and: [ self hasResized not ])
		ifTrue: [ ^ self ].

	session := Smalltalk session.
	self surface initializeResourcesOn: self