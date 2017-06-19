host space - drawing
render: aSpace
	self isValid
		ifFalse: [ ^ self ].

	self hasResized
		ifTrue: [ osWindowRenderer resetResources ].

	renderer render: aSpace