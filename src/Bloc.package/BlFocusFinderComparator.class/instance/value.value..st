evaluating
value: aFirstElement value: aSecondElement
	" I sort elements according to the following strategy:
	
	1) A rectangle that is located higher gets higher priority,
	so A will be higher in the sorted list than B:
	
	|----------|
	|    A     |       
	|__________|      
	
	|-----------|
	|     B     |
	|___________|
	
	2) A rectangle with smaller x coodinate of a left edge gets higher priority,
	A will be before B:
	Note: if layout is left to right, then B should be first (reversed order)
	
	|---------|  |---------|
	|    A    |  |    B    |
	|_________|  |_________|
	"
	<return: #Number>
	
	self bounds: firstBounds of: aFirstElement.
	self bounds: secondBounds of: aSecondElement.
	
	(firstBounds top < secondBounds top)
		ifTrue: [ ^ -1 ].
	
	(firstBounds top > secondBounds top)
		ifTrue: [ ^ 1 ].
	
	(firstBounds left < secondBounds left)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ 1 ]
			ifFalse: [ -1 ] ].
	
	(firstBounds left > secondBounds left)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ -1 ]
			ifFalse: [ 1 ] ].
	
	(firstBounds bottom < secondBounds bottom)
		ifTrue: [ ^ -1 ].
	
	(firstBounds bottom > secondBounds bottom)
		ifTrue: [ ^ 1 ].
	
	(firstBounds right < secondBounds right)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ 1 ]
			ifFalse: [ -1 ] ].
	
	(firstBounds right > secondBounds right)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ -1 ]
			ifFalse: [ 1 ] ].
	
	"elements are distinct, treat them as equal"
	^ 0