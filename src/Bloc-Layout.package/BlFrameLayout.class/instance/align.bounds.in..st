layout
align: anElement bounds: elementBounds in: theParentBounds
	| translation alignment allowedBounds |
	
	"take margin into account"
	allowedBounds := anElement margin inset: theParentBounds.
	
	"a composite alignment"
	alignment := anElement constraints frame alignment directed: self direction.
	translation := alignment translationOf: elementBounds in: allowedBounds.
	"fast return if there is no translation needed"
	translation isZero
		"this will take padding into account"
		ifTrue: [			
			^ elementBounds origin: allowedBounds origin extent: elementBounds extent ].
	^ elementBounds translateBy: translation