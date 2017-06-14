pulse
pulse
	| isPulseRequested |
	
	session == Smalltalk session
		ifFalse: [
			session == Smalltalk session.
			self beDirtyArea.
			self requestNextPulse ].
	
	isPulseRequested := self pulseRequested.
	nextPulseRequested := false.
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