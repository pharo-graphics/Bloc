layout
align: anElement bounds: elementBounds in: theParentBounds
	| translation alignment allowedBounds |
	
	"take margin into account"
	allowedBounds := anElement margin inset: theParentBounds.
	
	"a composite alignment"
	alignment := anElement constraints frame alignment directed: self direction.
	translation := alignment translationOf: elementBounds in: allowedBounds.

	translation x isZero
		ifTrue: [ translation := allowedBounds left @ translation y ].
	translation y isZero
		ifTrue: [ translation := translation x @ allowedBounds top ].

	^ elementBounds translateBy: translation