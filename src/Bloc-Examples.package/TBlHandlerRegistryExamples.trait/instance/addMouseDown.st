examples - add
addMouseDown
	<gtExample>
	| aRegistry |
	
	aRegistry := self emptyRegistry.
	self assert: aRegistry numberOfHandlers equals: 0.
	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	
	self assert: aRegistry numberOfHandlers equals: 1.
	
	^ aRegistry