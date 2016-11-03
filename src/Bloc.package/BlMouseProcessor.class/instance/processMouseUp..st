event processing entrypoint
processMouseUp: aMouseUpEvent
	"DragEnd, Simple click and Dbl click"

	self preProcess: aMouseUpEvent.
	"stop still down"
	isMouseStillDown := isMouseStillDown bitClear: aMouseUpEvent button.
	
	"dragend"
	self subprocessDragEndEvent: aMouseUpEvent.
	
	"click or dblclick"
	(self canBeClickEvent: aMouseUpEvent) ifTrue:[
		(self canBeDblClickEvent: aMouseUpEvent)
			ifTrue: [ 
				lastClickEvent := nil.
				self fireEvent: aMouseUpEvent asDblClickEvent ]
			ifFalse:[
				lastClickEvent := aMouseUpEvent.
				self fireEvent: aMouseUpEvent asClickEvent.
				 ] ].
	
	
	
	self postProcess: aMouseUpEvent