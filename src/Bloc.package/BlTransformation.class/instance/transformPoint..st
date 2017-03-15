transformation
transformPoint: aPoint
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>

	self hasMatrix
		ifFalse: [ ^ aPoint ].

	^ self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D transformPoint: aPoint ]
		ifFalse: [ 
			self ensure3D.
			matrix3D transformPoint: aPoint ]