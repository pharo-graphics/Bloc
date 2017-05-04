scaling
scaleX: aX Y: aY Z: aZ
	"Apply a scaling by the given factors"

	(aX = 1.0 and: [ aY = 1.0 and: [ aZ = 1.0 ] ])
		ifTrue: [ ^ self ].
	self setScaleX: aX Y: aY