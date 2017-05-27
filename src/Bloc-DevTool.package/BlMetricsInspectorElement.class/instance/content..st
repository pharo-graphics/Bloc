accessing
content: anElement
	contentElement := anElement.
	contentElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter. ].
	self addChild: contentElement