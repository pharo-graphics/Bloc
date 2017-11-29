heads - accessing
toHead: aBlElement
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Arrowhead must not be nil' ].
		
	self hasToHead
		ifTrue: [ self removeChild: self toHead ].
		
	toHead := aBlElement.
	toHead constraintsDo: [ :c | c ignoreByLayout ].
	self addChild: toHead