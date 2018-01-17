converting
convertButtonFromMouseButtonEvent: aMorphicEvent
	<return: #BlMouseButton>

	aMorphicEvent redButtonChanged
		ifTrue: [ ^ BlMouseButton primary ].
	aMorphicEvent blueButtonChanged
		ifTrue: [ ^ BlMouseButton middle ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ ^ BlMouseButton secondary ].
	^ BlMouseButton code: aMorphicEvent whichButton