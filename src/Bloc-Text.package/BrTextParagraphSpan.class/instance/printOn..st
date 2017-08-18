printing
printOn: aStream
	span
		ifNil: [ aStream nextPutAll: '(not yet initialized)' ]
		ifNotNil: [ span putOn: aStream from: spanStart to: spanEnd ]
	