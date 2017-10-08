converting
asMatrix
	^ self is2D
		ifTrue: [ BlMatrix2D new postTranslateX: self translation x Y: self translation y ]
		ifFalse: [ BlMatrix3D new postTranslateX: self translation x Y: self translation y Z: self translation z ]