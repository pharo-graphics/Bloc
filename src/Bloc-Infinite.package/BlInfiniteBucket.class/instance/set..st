accessing
set: index

	index > array size
		ifTrue: [ 
			self ensureNext.
			next set: index - array size ]
		ifFalse: [ 
			array byteAt: index put: true asBit ]