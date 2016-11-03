measure
measurementOf: anElement isHorizontal: isHorizontal
	<return: #Number>
	
	^ isHorizontal
		ifTrue: [ anElement measuredWidth ]
		ifFalse: [ anElement measuredHeight ]