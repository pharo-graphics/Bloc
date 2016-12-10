accessing
clear: index
	index > array size
		ifTrue: [
			next ifNotNil: [ :n | n clear: index - array size ] ]
		ifFalse: [
			array byteAt: index put: false asBit ]