comparing
hash
	^ self hasRoot
		ifTrue: [ self root hash bitXor: self class hash ]
		ifFalse: [ self class hash ]