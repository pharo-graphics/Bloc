transformation
transformBounds: aBounds
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>

	self hasMatrix
		ifFalse: [ ^ aBounds ].

	self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D transformBounds: aBounds ]
		ifFalse: [ 
			self ensure3D.
			matrix3D transformBounds: aBounds ].
		
	^ aBounds