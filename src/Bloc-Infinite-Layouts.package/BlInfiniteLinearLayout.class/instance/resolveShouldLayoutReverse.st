layout - computations
resolveShouldLayoutReverse
	<return: #Boolean>

	shouldReverseLayout := (self orientation isVertical or: [ self isLayoutRTL not ])
		ifTrue: [ reverseLayout ]
		ifFalse: [ reverseLayout not ].

	^ shouldReverseLayout