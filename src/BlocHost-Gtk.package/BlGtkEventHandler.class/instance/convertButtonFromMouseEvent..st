as yet unclassified
convertButtonFromMouseEvent: aGdkEvent

	aGdkEvent button = 1
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	aGdkEvent button = 2
		ifTrue: [ ^ BlMouseEvent middleButton ].
	aGdkEvent button = 3
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
	aGdkEvent button = 4
		ifTrue: [ ^ 4 ].
	aGdkEvent button = 5
		ifTrue: [ ^ 5 ]