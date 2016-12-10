accessing
scrollingOffset: aNumber
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Scrolling offset must not be negative!' ].

	scrollingOffset := aNumber