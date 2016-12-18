scrolling
computeScrollVectorForPosition: aPosition
	<return: #Point>
	| aFirstChildPos aDirection |
	
	self hasChildren
		ifFalse: [ ^ nil ].
	
	aFirstChildPos := self childPositionOf: (self childAt: 1).
	aDirection := (aPosition < aFirstChildPos) ~= shouldReverseLayout
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	
	^ self orientation isHorizontal
		ifTrue: [ aDirection @ 0 ]
		ifFalse: [ 0 @ aDirection ]