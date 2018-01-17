event processing
subprocessDragEnterExitEvent: aMouseEvent
	| newEnteredTargets newExitedTargets |

	self 
		assert: [ currentDragTarget isNotNil ]
		description: [ 'Can not process drag mouse event as enter / exit when there is no dragged element' ].
	
	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	lastOverTarget = aMouseEvent target ifFalse:[
		newExitedTargets := lastEnteredTargets reject: [ :anElement | currentEnteredTargets includes: anElement ].
		newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
		self fireAsDragLeaveEvent: aMouseEvent targets: newExitedTargets.
		self fireAsDragEnterEvent: aMouseEvent targets: newEnteredTargets ].

	"fire dragover event to current target"
	self fireAsDragOverEvent: aMouseEvent