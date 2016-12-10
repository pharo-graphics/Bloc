children - accessing
childClosestToEnd
	"Return the child closes to end.
	Sender should check if there is enough children"
	<return: #BlElement>

	^ self childAt: (shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ self childrenCount ])