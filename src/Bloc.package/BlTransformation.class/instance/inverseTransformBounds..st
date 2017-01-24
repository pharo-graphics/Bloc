transformation
inverseTransformBounds: aBounds
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>

	self hasMatrix
		ifFalse: [ ^ aBounds ].

	self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D inverted transformBounds: aBounds ]
		ifFalse: [ 
			self ensure3D.
			matrix3D inverted transformBounds: aBounds ].
		
	^ aBounds