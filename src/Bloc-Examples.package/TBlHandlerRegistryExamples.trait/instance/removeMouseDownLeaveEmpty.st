examples - remove
removeMouseDownLeaveEmpty
	<gtExample>
	| aRegistry |
	
	aRegistry := self removeMouseUpLeaveMouseDown.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseDownEvent]).
	
	self assert: aRegistry numberOfHandlers equals: 0.
	
	^ aRegistry