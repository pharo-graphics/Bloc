accessing
image: aGalleryImage

	image = aGalleryImage
		ifTrue: [ ^ self ].
	
	form := nil.
	image := aGalleryImage.
	itemElement text: ((SpText fromString: aGalleryImage id asString)
		attributes: {
			SpTextForegroundAttribute paint: Color white.
			SpTextSpacingAttribute spacing: 2.
			SpFontSizeAttribute size: 14.
			SpFontWeightAttribute weight: 50.
			SpFontFamilyAttribute named: 'Helvetica Neue'
		}).
	
	self loadImage