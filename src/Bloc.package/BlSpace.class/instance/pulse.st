pulse
pulse
	self ensureSession.

	self pulseRequested
		ifFalse: [ ^ self ].

	"We must update focused element before processing events, otherwise keyboard events,
	for example, will be handled by the wrong element"
	self doUpdateFocus.

	self
		dispatchTimeEvent: BlSpaceEventProcessEndEvent
		during: [ self hasHostSpace ifTrue: [ self processEvents ] ].

	self
		dispatchTimeEvent: BlSpaceLayoutEndEvent
		during: [ self isLayoutRequested ifTrue: [ self doLayout ] ].

	self
		dispatchTimeEvent: BlSpaceRenderEndEvent
		during: [ self hasDirtyAreas ifTrue: [ self render ] ].
		
	nextPulseRequested := false