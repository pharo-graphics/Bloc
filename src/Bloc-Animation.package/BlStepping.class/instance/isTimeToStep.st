pulse
isTimeToStep
	lastStepTimestamp ifNil: [ ^ true ].
	^ DateAndTime now - lastStepTimestamp >= self duration