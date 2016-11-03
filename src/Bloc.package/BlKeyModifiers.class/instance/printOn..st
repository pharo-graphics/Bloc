printing
printOn: aStream
	aStream nextPutAll: self class name; space; nextPut: $[.
	self isAlt ifTrue: [ aStream nextPutAll: 'alt'; space ].
	self isCmd ifTrue: [ aStream nextPutAll: 'super|cmd'; space ].
	self isCtrl ifTrue: [ aStream nextPutAll: 'ctrl'; space ].
	self isShift ifTrue: [ aStream nextPutAll: 'shift'; space ].
	aStream nextPut: $]