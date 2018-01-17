examples - remove
removeAllMouseDownFromTwiceLeaveUp
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownTwiceAndMouseUp.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	
	self assert: aRegistry numberOfHandlers equals: 1.
	
	^ aRegistry