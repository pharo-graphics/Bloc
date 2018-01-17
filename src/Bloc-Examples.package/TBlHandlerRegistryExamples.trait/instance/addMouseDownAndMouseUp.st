examples - add
addMouseDownAndMouseUp
	<gtExample>
	| aRegistry |

	aRegistry := self addMouseDown.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	
	self assert: aRegistry numberOfHandlers equals: 2.
	
	^ aRegistry