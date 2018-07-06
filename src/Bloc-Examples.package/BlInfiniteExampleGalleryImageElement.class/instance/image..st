accessing
image: aGalleryImage

	image = aGalleryImage
		ifTrue: [ ^ self ].
	
	form := nil.
	image := aGalleryImage.
	itemElement text: ((BlRopedText string: aGalleryImage id asString)
		attributes: {
			BrTextForegroundAttribute paint: Color white.
			BrFontSizeAttribute size: 14.
			BrFontWeightAttribute weight: 50.
			BrFontFamilyAttribute named: 'Helvetica Neue'
		}).
	
	self loadImage