initialization
top: aTop right: aRight bottom: aBottom left: aLeft
	self
		assert: [ top isNil ]
		description: [ 'Instets is immutable and can not be changed' ].
	self
		assert: [ right isNil ]
		description: [ 'Instets is immutable and can not be changed' ].
	self
		assert: [ bottom isNil ]
		description: [ 'Instets is immutable and can not be changed' ].
	self
		assert: [ left isNil ]
		description: [ 'Instets is immutable and can not be changed' ].

	top := aTop.
	right := aRight.
	bottom := aBottom.
	left := aLeft