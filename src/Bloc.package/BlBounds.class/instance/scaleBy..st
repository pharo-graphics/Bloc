transforming
scaleBy: aFactor
	
	^ aFactor isPoint
		ifTrue: [ self scaleX: aFactor x Y: aFactor y ]
		ifFalse: [ aFactor isNumber
			ifTrue: [ self scaleX: aFactor Y: aFactor ]
			ifFalse: [ self scaleX: aFactor x Y: aFactor y ] ]