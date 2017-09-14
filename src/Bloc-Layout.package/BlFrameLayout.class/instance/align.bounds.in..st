layout
align: anElement bounds: elementBounds in: allowedBounds
	| translation alignment |
	
	"a composite alignment"
	alignment := anElement constraints frame alignment directed: self direction.
	translation := alignment translationOf: elementBounds in: allowedBounds.
	"fast return if there is no translation needed"
	translation isZero
		"this will take padding into account"
		ifTrue: [			
			^ elementBounds origin: allowedBounds origin extent: elementBounds extent ].
	^ elementBounds translateBy: translation