focus requesting
looseFocus: aChildElement
	"Propagate focus loose up in the scene graph with an original
	element that looses focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].
		
	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent looseFocus: aChildElement ]
		ifFalse: [ self space looseFocusFor: aChildElement ]