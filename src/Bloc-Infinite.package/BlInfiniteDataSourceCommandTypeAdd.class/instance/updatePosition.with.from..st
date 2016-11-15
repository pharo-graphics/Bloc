dispatch
updatePosition: aPosition with: aCommand from: myCommand
	| pos |
	pos := aPosition.
	
	myCommand positionStart <= pos
		ifTrue: [ pos := pos - myCommand itemCount ]
		ifFalse: [ myCommand positionStart: myCommand positionStart + 1 ].

	^ pos