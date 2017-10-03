printing
printOn: aStream
	
	self changedValue printOn: aStream.
	
	self wasNotified
		ifTrue: [ aStream nextPutAll: ' => Notified' ].