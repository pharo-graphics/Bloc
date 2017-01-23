private
ensure2D
	"I make sure that matrix2D is initialized and ready to be used.
	Note: matrix3D must not exists when using me!"
	
	self
		assert: [ self is3D not ]
		description: [ 'I can not downgrade from 3D transformation to 2D!' ].
		
	matrix2D ifNil: [ matrix2D := self defaultMatrix2D ]