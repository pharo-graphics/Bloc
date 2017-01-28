converting
convertButtonFromMouseButtonEvent: aMorphicEvent

	aMorphicEvent redButtonChanged
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	aMorphicEvent blueButtonChanged
		ifTrue: [ ^ BlMouseEvent middleButton ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
		
	^ aMorphicEvent whichButton