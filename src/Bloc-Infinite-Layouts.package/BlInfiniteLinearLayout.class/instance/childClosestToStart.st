children - accessing
childClosestToStart
	"Return the child closes to start.
	Sender should check if there is enough children"
	<return: #BlElement>

	^ self childAt: (shouldReverseLayout
		ifTrue: [ self childrenCount ]
		ifFalse: [ 1 ])