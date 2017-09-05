focus requesting
looseFocus
	self isAttachedToSceneGraph
		ifTrue: [ self looseFocus: self ]
		ifFalse: [ self focused: false ]