accessing
image: aGalleryImage

	image = aGalleryImage
		ifTrue: [ ^ self ].
	
	form := nil.
	image := aGalleryImage.
	self loadImage