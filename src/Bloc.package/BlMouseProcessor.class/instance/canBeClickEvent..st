event testing
canBeClickEvent: aMouseUpEvent
	^ dndInProgress not
		and: [ (lastMouseDownEvent isNotNil and: [ lastMouseDownEvent primaryButtonPressed ])
				and: [ aMouseUpEvent target = lastMouseDownEvent target ] ]