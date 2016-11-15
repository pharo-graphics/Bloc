accessing
remove: index

	^ index > array size
		ifTrue: [ 
			self ensureNext.
			next remove: index - array size ]
		ifFalse: [ 
			| value |
			value := array byteAt: index.
			array := array copyWithout: index.
			value = true asBit ]