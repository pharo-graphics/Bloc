layout
align: anElement bounds: elementBounds in: allowedBounds
	| translation |
	translation := (anElement constraints frame alignment directed: self direction) translate: elementBounds in: allowedBounds.
	"fast return if there is no translation needed"
	translation isZero
		ifTrue: [ ^ elementBounds ].
	^ elementBounds translateBy: translation