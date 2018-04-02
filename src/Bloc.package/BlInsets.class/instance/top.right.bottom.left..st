initialization
top: aTop right: aRight bottom: aBottom left: aLeft
	self
		assert: [ top isNil ]
		description: [ 'Insets is immutable and can not be changed' ].
	self
		assert: [ right isNil ]
		description: [ 'Insets is immutable and can not be changed' ].
	self
		assert: [ bottom isNil ]
		description: [ 'Insets is immutable and can not be changed' ].
	self
		assert: [ left isNil ]
		description: [ 'Insets is immutable and can not be changed' ].

	top := aTop.
	right := aRight.
	bottom := aBottom.
	left := aLeft