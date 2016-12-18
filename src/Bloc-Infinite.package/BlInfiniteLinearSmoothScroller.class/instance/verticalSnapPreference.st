physics
verticalSnapPreference
	"When scrolling towards a child element, I define whether we should
	align the top or the bottom edge of the child with the parent InfiniteElement"
	<return: #Symbol>

	^ (self hasTargetVector not or: [ self targetVector y isZero ])
		ifTrue: [ SnapToAny ]
		ifFalse: [ self targetVector y > 0
			ifTrue: [ SnapToEnd ]
			ifFalse: [ SnapToStart ] ]