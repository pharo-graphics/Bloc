private accessing
axis: isHorizontal

	^ isHorizontal 
		ifTrue: [ horizontalAxis ]
		ifFalse: [ verticalAxis ]