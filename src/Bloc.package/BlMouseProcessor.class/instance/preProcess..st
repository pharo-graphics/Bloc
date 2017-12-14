event processing
preProcess: aMouseEvent
	| aTarget |
	
	aTarget := self processPicking: aMouseEvent.
	aMouseEvent
		source: self space root;"maybe the space?"
		target: aTarget.
	"mouse move is only fired when no dnd is in progress (else it is a drag event)"
	dndInProgress ifFalse: [ self fireEvent: aMouseEvent ].
	"now we can update the cursor from the target"
	self updateCursorFrom: aTarget