mouse move
processMouseEnterExitEvent: aMouseEvent
	| newEnteredTargets newExitedTargets |

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	lastOverTarget = aMouseEvent target ifFalse:[
			"fire exit events"
			newExitedTargets := lastEnteredTargets
				reject: [ :let | currentEnteredTargets includes: let ].
			self fireAsExitEvent: aMouseEvent targets: newExitedTargets.
			
			"fire enter events"
			 newEnteredTargets := currentEnteredTargets
				reject: [ :cet | lastEnteredTargets includes: cet ].
			self fireAsEnterEvent: aMouseEvent targets: newEnteredTargets.
			
			"fire mouseout to last overed target"
			lastOverTarget isNotNil
				ifTrue: [ self fireAsMouseOutEvent: aMouseEvent ].
				
			"fire dragover event to current target"
			self fireAsMouseOverEvent: aMouseEvent.
	].
	
	lastOverTarget := aMouseEvent target.
	lastEnteredTargets := currentEnteredTargets