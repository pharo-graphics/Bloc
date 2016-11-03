pulse
pulse
	self checkSession.
	self dispatchTimeEvent: BlSpaceEventProcessEndEvent during: [ self processEvents ].
	self dispatchTimeEvent: BlSpaceLayoutEndEvent during: [ 
		self pulseRequested ifFalse:[^ self].
		self doLayout ].
	self dispatchTimeEvent: BlSpaceRenderEndEvent during: [ 
		self pulseRequested ifFalse:[^ self].
		self render ].
	nextPulseRequested := false