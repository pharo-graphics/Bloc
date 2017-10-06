instance creation
asScalableElement: anElement
	^ BlElement new
		addChild: anElement;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 20 ]