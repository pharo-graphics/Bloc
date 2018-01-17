examples - remove
removeAllMouseDownFromTwice
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownTwice.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	
	self assert: aRegistry numberOfHandlers equals: 0.
	
	^ aRegistry