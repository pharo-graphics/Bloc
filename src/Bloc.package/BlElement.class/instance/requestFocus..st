focus requesting
requestFocus: aChildElement
	"Propagate focus request up in the scene graph with an original
	element that requested focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].

	self
		assert: [ self hasParent or: [ self space root == self ] ]
		description: [ 'I must have a parent or be a space root' ].

	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent requestFocus: aChildElement ]
		ifFalse: [ self space requestFocusFor: aChildElement ]