examples - remove
removeMouseUpLeaveMouseDown
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownAndMouseUp.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseUpEvent]).
	
	self assert: aRegistry numberOfHandlers equals: 1.
	
	^ aRegistry