mouse move
processMouseEnterLeaveEvent: aMouseEvent
	| newLeavedTargets newEnteredTargets  |

	"mouse is moved over the same element, no need to process enter/leave events"
	lastOverTarget = aMouseEvent target
		ifTrue: [ ^ self ].

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	"fire mouseout to the previous overed target"
	lastOverTarget isNotNil
		ifTrue: [ self fireAsMouseOutEvent: aMouseEvent ].
	
	"fire mouse leave events"
	newLeavedTargets := lastEnteredTargets reject: [ :anElement | (currentEnteredTargets includes: anElement) ].
	newLeavedTargets := newLeavedTargets select: #isAttachedToSceneGraph.

	self fireAsLeaveEvent: aMouseEvent targets: newLeavedTargets.
	
	"fire mouse event to the current target"
	self fireAsMouseOverEvent: aMouseEvent.
	
	"fire enter events"
	newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
	self fireAsEnterEvent: aMouseEvent targets: newEnteredTargets.

	lastOverTarget := aMouseEvent target.
	lastEnteredTargets := currentEnteredTargets