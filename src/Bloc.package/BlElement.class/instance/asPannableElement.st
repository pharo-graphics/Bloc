*Bloc-Utilities - Pannable
asPannableElement
	| pannable |
	self removeFromParent.
	pannable := BlPannableElement new.
	pannable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	pannable contentElement: self.
	^ pannable