transformation
invert
	self hasMatrix
		ifFalse: [ ^ self ].
		
	self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D := matrix2D inverted ]
		ifFalse: [ 
			self ensure3D.
			matrix3D := matrix3D inverted ]