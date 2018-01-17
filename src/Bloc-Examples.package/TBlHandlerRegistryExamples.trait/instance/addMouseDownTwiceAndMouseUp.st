examples - add
addMouseDownTwiceAndMouseUp
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownTwice.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	
	self assert: aRegistry numberOfHandlers equals: 3.
	
	^ aRegistry