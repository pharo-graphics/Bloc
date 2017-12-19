printing
printAbsolute
	^ self isAbsolute
		ifTrue: [ 'absolute' ]
		ifFalse: [ 'relative' ]