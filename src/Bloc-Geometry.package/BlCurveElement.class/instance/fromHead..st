heads - accessing
fromHead: aBlElement
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Arrowhead must not be nil' ].
		
	self hasFromHead
		ifTrue: [ self removeChild: self fromHead ].
		
	fromHead := aBlElement.
	fromHead constraintsDo: [ :c | c ignoreByLayout ].
	self addChild: fromHead