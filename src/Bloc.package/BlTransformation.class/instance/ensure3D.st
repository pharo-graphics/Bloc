private
ensure3D
	"I make sure that matrix3D is initialized and ready to be used.
	Note: if I only have a 2D matrix I first convert it to 3D and then delete"
	
	matrix3D
		ifNotNil: [ ^ self ].
	
	matrix3D := matrix2D
		ifNotNil: [ self shouldBeImplemented ]
		ifNil: [ self defaultMatrix3D ]