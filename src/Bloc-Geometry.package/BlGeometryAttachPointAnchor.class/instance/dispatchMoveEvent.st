event dispatching
dispatchMoveEvent
	"I dispatch anchor moved event"
	
	moveDispatched
		ifTrue: [ ^ self ].
	moveDispatched := true.
	
	[ self dispatchEvent: (BlGeometryAnchorMoved new anchor: self) ]
		ensure: [ moveDispatched := false ]