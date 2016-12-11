accessing
remove: index

	^ index > array size
		ifTrue: [ 
			self ensureNext.
			next remove: index - array size ]
		ifFalse: [ 
			| value |
			value := (array byteAt: index) = true asBit.
			array replaceFrom: index to: array size - 1 with: array startingAt: index + 1.
			array byteAt: array size put: (next
				ifNil: [ false asBit ]
				ifNotNil: [ (next get: 1) asBit ]).
			next
				ifNotNil: [ next remove: 1 ].
			value ]