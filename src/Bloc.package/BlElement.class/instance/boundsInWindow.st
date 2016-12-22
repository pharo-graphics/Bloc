geometry bounds
boundsInWindow
	^ self isAttachedToSceneGraph
		ifTrue: [ boundsCache boundsInSpace scaleBy: self space windowScale ]
		ifFalse: [ boundsCache boundsInSpace ]