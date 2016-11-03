converting
convertButton: osButton
	osButton = 1 ifTrue: [ ^ BlMouseEvent primaryButton ].
	osButton = 2 ifTrue: [ ^ BlMouseEvent middleButton ].
	osButton = 3 ifTrue: [ ^ BlMouseEvent secondaryButton ].
	^ osButton