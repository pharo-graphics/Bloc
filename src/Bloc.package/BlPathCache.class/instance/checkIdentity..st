session management
checkIdentity: aCanvas
	canvasIdentity = aCanvas identity
		ifFalse: [ self releaseCache ]