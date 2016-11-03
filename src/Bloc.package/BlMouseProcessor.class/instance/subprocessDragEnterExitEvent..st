event processing
subprocessDragEnterExitEvent: aMouseEvent
	| newEnteredTargets newExitedTargets |
	currentDragTarget ifNil:[^ self].
	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	lastOverTarget = aMouseEvent target ifFalse:[
		
			"fire dragleave events"
			newExitedTargets := lastEnteredTargets
				reject: [ :let | currentEnteredTargets includes: let ].
			self fireAsDragLeaveEvent: aMouseEvent targets: newExitedTargets.
			
			"fire dragenter events"
			 newEnteredTargets := currentEnteredTargets
				reject: [ :cet | lastEnteredTargets includes: cet ].
			self fireAsDragEnterEvent: aMouseEvent targets: newEnteredTargets.
			
			 ].
			"fire dragover event to current target"
			self fireAsDragOverEvent: aMouseEvent.
	
	