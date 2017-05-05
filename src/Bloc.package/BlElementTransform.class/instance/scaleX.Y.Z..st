scaling
scaleX: aX Y: aY Z: aZ
	"Apply a scaling by the given factors"

	((aX closeTo: 1.0) and: [ (aY closeTo: 1.0) and: [ aZ closeTo: 1.0 ] ])
		ifTrue: [ ^ self ].
	self setScaleX: aX Y: aY Z: aZ