accessing
contentElement: anElement
	contentElement := anElement.
	
	anElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: contentElement