physics
startAfterEdgeFor: aVelocity start: aStart min: aMin max: aMax
	| isPositive anEdge anOverDistance shouldKeepInscreasing |
	
	(aStart > aMin and: [ aStart < aMax ])
		"Position is already valid, return"
		ifTrue: [ isFinished := true. ^ self ].
	
	isPositive := aStart > aMax.
	anEdge := isPositive
		ifTrue: [ aMax ]
		ifFalse: [ aMin ].
	
	anOverDistance := aStart - anEdge.
	shouldKeepInscreasing := (anOverDistance * aVelocity) >= 0.
	
	shouldKeepInscreasing
		"Will result in a bounce or a to_boundary depending on velocity."
		ifTrue: [ self startBounceAfterEdgeFor: aVelocity start: aStart end: anEdge ]
		ifFalse: [ 
			| aTotalDistance |
			aTotalDistance := self splineFlingDistanceFor: aVelocity.
			(aTotalDistance > anOverDistance abs)
				ifTrue: [ self
					fling: aVelocity
					start: aStart
					min: (isPositive ifTrue: [ aMin ] ifFalse: [ aStart ] )
					max: (isPositive ifTrue: [ aStart ] ifFalse: [ aMax ] )
					over: overshotDistance ]
				ifFalse: [ self startSpringbackFor: aVelocity start: aStart end: anEdge ] ]