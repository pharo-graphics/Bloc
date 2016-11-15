private
isInPool: anObject
	"Return true of anObject is currently in the pool,
	false otherwise.
	anObject must not be nil"
	<return: #Boolean>
	self assert: anObject isNotNil.
	
	1 to: poolSize do: [ :i |
		(pool at: i) == anObject
			ifTrue: [ ^ true ] ].
	^ false