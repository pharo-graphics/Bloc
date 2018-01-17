event testing
canBeClickEvent: aMouseUpEvent
	^ dndInProgress not
		and: [ (previousMouseDownEvent isNotNil and: [ previousMouseDownEvent primaryButtonPressed ])
				and: [ aMouseUpEvent target = previousMouseDownEvent target ] ]