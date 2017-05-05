translation
translateX: aX Y: aY Z: aZ
	"Apply a translation by the given deltas"

	(aX isZero and: [ aY isZero and: [ aZ isZero ] ])
		ifTrue: [ ^ self ].
	self setTranslateX: aX Y: aY Z: aZ