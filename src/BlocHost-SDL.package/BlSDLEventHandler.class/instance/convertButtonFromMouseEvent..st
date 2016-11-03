as yet unclassified
convertButtonFromMouseEvent: aSDLMouseEvent
	aSDLMouseEvent button = 1
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	aSDLMouseEvent button = 2
		ifTrue: [ ^ BlMouseEvent middleButton ].
	aSDLMouseEvent button = 3
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
	aSDLMouseEvent button = 4
		ifTrue: [ ^ 4 ].
	aSDLMouseEvent button = 5
		ifTrue: [ ^ 5 ]