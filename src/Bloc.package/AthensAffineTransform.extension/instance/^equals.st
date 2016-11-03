*Bloc
= anAffineTransform

	self == anAffineTransform ifTrue: [ ^ true ].
	self class = anAffineTransform class ifFalse: [ ^ false ].
	self x = anAffineTransform x ifFalse: [ ^ false ].	
	self y = anAffineTransform y ifFalse: [ ^ false ].
	self sx = anAffineTransform sx ifFalse: [ ^ false ].	
	self sy = anAffineTransform sy ifFalse: [ ^ false ].
	self shx = anAffineTransform shx ifFalse: [ ^ false ].	
	self shy = anAffineTransform shy ifFalse: [ ^ false ].
	^ true