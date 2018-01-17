examples - add
addMouseDownTwice
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDown.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	
	self assert: aRegistry numberOfHandlers equals: 2.
	
	^ aRegistry