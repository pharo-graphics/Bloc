accessing
image: anImage

	image = anImage
		ifTrue: [ ^ self ].

	image := anImage.
	itemElement image: anImage