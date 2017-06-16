pulse
ensureSession
	"Checke current session and perform required operations if it changed since last frame"

	session == Smalltalk session
		ifTrue: [ ^ self ].

	session := Smalltalk session.
	self beDirtyArea.
	self requestNextPulse