focus requesting
looseFocus: aChildElement
	"Propagate focus loose up in the scene graph with an original
	element that looses focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].

	self
		assert: [ self hasParent or: [ self space root == self ] ]
		description: [ 'I must have a parent or be a space root' ].
		
	self hasParent
		ifTrue: [ self parent looseFocus: aChildElement ]
		ifFalse: [ self space looseFocusFor: aChildElement ]