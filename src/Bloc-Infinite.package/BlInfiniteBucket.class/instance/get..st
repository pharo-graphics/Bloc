accessing
get: index
	^ index > array size
		ifTrue: [
			self ensureNext.
			next get: index - array size ]
		ifFalse: [ (array byteAt: index) = true asBit ]