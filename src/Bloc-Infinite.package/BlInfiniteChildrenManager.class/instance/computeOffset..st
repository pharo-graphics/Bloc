private
computeOffset: index
	| limit offset |
	
	index <= 0
		ifTrue: [ ^ 0 ].
	
	limit := controller childrenCount.
	offset := index.
	
	[ offset <= limit ] whileTrue: [ 
		| removedBefore diff |
		removedBefore := bucket countOnesBefore: offset.
		diff := index - (offset - removedBefore).
		diff = 0
			ifTrue: [ 
				[ bucket get: offset ]
					whileTrue: [ offset := offset + 1 ].
				^ offset ]
		ifFalse: [ offset := offset + diff ] ].
	^ 0