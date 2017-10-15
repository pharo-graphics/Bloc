private
ensureMatrix
	self hasMatrix
		ifTrue: [ ^ self ].
	self is2D
		ifTrue: [ self ensure2D ]
		ifFalse: [ self ensure3D ].
	transformation multiplyOn: matrix in: owner