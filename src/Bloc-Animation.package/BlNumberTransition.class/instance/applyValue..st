pulse
applyValue: aValue
	previousValue = aValue
		ifTrue: [ ^ self ].
	previousValue := aValue.
	super applyValue: aValue