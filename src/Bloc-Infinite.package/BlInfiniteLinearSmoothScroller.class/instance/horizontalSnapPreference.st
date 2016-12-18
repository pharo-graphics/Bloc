physics
horizontalSnapPreference
	"When scrolling towards a child element, I define whether we should
	align the left or the right edge of the child with the parent InfiniteElement"
	<return: #Symbol>

	^ (self hasTargetVector not or: [ self targetVector x isZero ])
		ifTrue: [ SnapToAny ]
		ifFalse: [ self targetVector x > 0
			ifTrue: [ SnapToEnd ]
			ifFalse: [ SnapToStart ] ]