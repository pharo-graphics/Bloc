dispatch
apply: aCommand onPosition: aPosition
	| newPosition |
	newPosition := aPosition.

	aCommand positionStart <= aPosition
		ifTrue: [
			| end |
			end := aCommand positionStart + aCommand itemCount.
			end > aPosition ifTrue: [
				^ BlInfiniteElement noPosition ].	
			newPosition := aPosition - aCommand itemCount ].
		
	^ newPosition