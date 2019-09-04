Extension { #name : #AbstractFileReference }

{ #category : #'*Bloc-Images' }
AbstractFileReference >> gtBinaryContents [
	self binaryReadStreamDo: [ :stream |
		^ stream contents ]
]
