printing
printOn: aStream

	self class ~= BlStrokeLineCap
		ifTrue: [ aStream nextPutAll: self class capName ]
		ifFalse: [ aStream nextPutAll: 'Line Cap' ]