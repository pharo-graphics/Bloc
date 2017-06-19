renderer - rendering
prepareToRender: aSpace
	"I check if window extent changed since last rendering step and if yes, recreate resources"

	self hasResized
		ifFalse: [ ^ self ].

	session := Smalltalk session.
	self surface initializeResourcesOn: self