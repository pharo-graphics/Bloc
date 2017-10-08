converting
asMatrix
	<return: #BlMatrix>

	^ self isRotation2D
		ifTrue: [ BlMatrix2D rotation: self angle ]
		ifFalse: [ BlMatrix3D fromQuaternion: self asQuaternion ]