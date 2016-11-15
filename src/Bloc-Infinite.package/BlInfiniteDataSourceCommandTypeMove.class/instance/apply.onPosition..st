dispatch
apply: aCommand onPosition: aPosition
	| newPosition |
	
	aCommand positionStart = aPosition
		ifTrue: [ newPosition := aCommand itemCount ]
		ifFalse: [ 
			newPosition := aPosition.
			(aCommand positionStart < aPosition)
				ifTrue: [ newPosition := aPosition - 1 ].
			(aCommand itemCount <= aPosition)
				ifTrue: [ newPosition := aPosition + 1 ] ].
	
	^ newPosition