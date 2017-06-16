printing
printOn: aStream

	self class ~= BlStrokeLineJoin
		ifTrue: [ aStream nextPutAll: self class joinName ]
		ifFalse: [ aStream nextPutAll: 'Line Join' ]