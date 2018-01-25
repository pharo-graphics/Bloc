accessing
overlayElement: anOverlayElement

	self
		assert: [ anOverlayElement isNotNil ]
		description: [ 'Overlay element must not be nil' ].

	overlayElement := anOverlayElement