pulse
pulse
	| isPulseRequested |
	isPulseRequested := self pulseRequested.
	nextPulseRequested := false.
	self checkSession.
	self doUpdateFocus.
	self dispatchTimeEvent: BlSpaceEventProcessEndEvent during: [ self processEvents ].
	self dispatchTimeEvent: BlSpaceLayoutEndEvent during: [ 
		isPulseRequested
			ifFalse: [ ^ self ].
		self doLayout ].
	self dispatchTimeEvent: BlSpaceRenderEndEvent during: [ 
		isPulseRequested
			ifFalse: [ ^ self ].
		self render ].