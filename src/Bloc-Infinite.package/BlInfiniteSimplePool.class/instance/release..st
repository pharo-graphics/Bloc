pool
release: anObject
	"Adds anObject to the pool and return true if successfully added,
	false otherwise.
	anObject must not be nil"
	<return: #Boolean>
	self assert: anObject isNotNil.

	(self isInPool: anObject)
		ifTrue: [ Error signal: anObject asString, ' is already in the pool!' ].

	^ (poolSize < pool size)
		ifTrue: [ 
			pool at: poolSize + 1 put: anObject.
			poolSize := poolSize + 1.
			true
		]
		ifFalse: [ false ]