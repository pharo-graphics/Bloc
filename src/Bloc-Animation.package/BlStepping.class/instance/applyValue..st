pulse
applyValue: myself
	self isTimeToStep ifFalse: [ ^ self ].
	lastStepTimestamp := DateAndTime now.
	super applyValue: lastStepTimestamp