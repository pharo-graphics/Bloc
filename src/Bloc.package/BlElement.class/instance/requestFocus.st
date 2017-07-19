focus requesting
requestFocus
	self isAttachedToSceneGraph
		ifTrue: [ self space requestFocusFor: self ]
		ifFalse: [ self focused: true ]