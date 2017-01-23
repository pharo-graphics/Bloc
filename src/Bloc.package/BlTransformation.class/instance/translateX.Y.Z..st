translation
translateX: aX Y: aY Z: aZ
	"Apply a translation by the given deltas"

	(aX isZero and: [ aY isZero and: [ aZ isZero ] ])
		ifTrue: [ ^ self ].

	(self is3D or: [ aZ isZero not ])
		ifTrue: [ 
			self ensure3D.
			matrix3D preTranslateX: aX Y: aY Z: aZ ]
		ifFalse: [ 
			self ensure2D.
			matrix2D preTranslateX: aX Y: aY ]