layout
align: anElement bounds: elementBounds in: allowedBounds
	| translation alignment |
	
	"a composite alignment"
	alignment := anElement constraints frame alignment directed: self direction.
	translation := alignment translationOf: elementBounds in: allowedBounds.
	"fast return if there is no translation needed"
	translation isZero
		ifTrue: [ ^ elementBounds ].
	^ elementBounds translateBy: translation