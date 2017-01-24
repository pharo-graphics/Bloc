scaling
scaleX: aX Y: aY Z: aZ
	"Apply a scaling by the given factors"

	(aX = 1.0 and: [ aY = 1.0 and: [ aZ = 1.0 ] ])
		ifTrue: [ ^ self ].

	(self is3D or: [ aZ ~= 1.0 ])
		ifTrue: [ 
			self ensure3D.
			matrix3D postScaleX: aX Y: aY Z: aZ ]
		ifFalse: [ 
			self ensure2D.
			matrix2D postScaleX: aX Y: aY ]