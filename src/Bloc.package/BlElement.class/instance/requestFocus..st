focus requesting
requestFocus: aChildElement
	"Propagate focus request up in the scene graph with an original
	element that requested focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].

	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent requestFocus: aChildElement ]
		ifFalse: [ self space requestFocusFor: aChildElement ]