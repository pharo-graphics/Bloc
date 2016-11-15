pool
acquire
	"Returns an object from the pool if there is one,
	or nil otherwise"
	<return: #Object or: nil>

	^ poolSize > 0
		ifTrue: [ 
			|  object |
			object := pool at: poolSize.
			pool at: poolSize put: nil.
			poolSize := poolSize - 1.
			object ]
		ifFalse: [ nil ]