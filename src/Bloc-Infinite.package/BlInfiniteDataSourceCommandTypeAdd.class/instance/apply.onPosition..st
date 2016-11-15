dispatch
apply: aCommand onPosition: aPosition
	|newPosition|
	
	aCommand positionStart <= aPosition
		ifTrue: [ newPosition := aPosition + aCommand itemCount ]
		ifFalse: [ newPosition := aPosition ].

	^ newPosition