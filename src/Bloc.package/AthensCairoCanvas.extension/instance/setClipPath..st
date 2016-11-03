*Bloc
setClipPath: aPathOrNil
	
	aPathOrNil 
		ifNil: [ self resetClip ]
		ifNotNil: [
			self newPath;
				loadPath:(aPathOrNil asAthensShapeOn: self);
				primClip
			]