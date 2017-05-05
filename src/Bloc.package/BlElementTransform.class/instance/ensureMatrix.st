private
ensureMatrix
	self hasMatrix ifNotNil: [ ^ self ].
	self is2D
		ifTrue: [ self ensure2D ]
		ifFalse: [ self ensure3D ]