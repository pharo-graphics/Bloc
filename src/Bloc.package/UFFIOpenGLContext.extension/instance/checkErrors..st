*Bloc
checkErrors: aBlock
	| error |
	[(error := self gl getError) ~= GL_NO_ERROR] whileTrue: [
		| errorMessage |
		errorMessage := ErrorDictionary at: error ifAbsent: [ error asString ].
		errorMessage := '[', aBlock value asString, '] ', errorMessage.
		Transcript show: 'OpenGL error: '; show: errorMessage; cr.
		FileStream stderr nextPutAll: 'OpenGL error: '; nextPutAll: errorMessage; lf.
	]