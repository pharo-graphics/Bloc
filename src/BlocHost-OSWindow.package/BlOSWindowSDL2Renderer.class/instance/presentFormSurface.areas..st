updating screen
presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas
	[ 
		| pitchHolder pixels pitch destinationForm aWindowScale dirtyAreas |
		pixels := ExternalAddress new.
		pitchHolder := FFIExternalArray externalNewType: 'int' size: 1.
		[
			texture lockPixels: pixels pitch: pitchHolder getHandle.
			pitch := pitchHolder at: 1.
		] ensure: [ pitchHolder free ].

		destinationForm := BlExternalForm extent: textureExtent depth: 32 bits: pixels.
		
		"Damaged rectangles are defined in user coordinates (bloc space).
		We have to convert damage to window space, since we want to support high dpi displays"
		aWindowScale := aBlHostRendererFormSurface scaleFactor.
		dirtyAreas := aCollectionOfAreas collect: [ :aRectangle | aRectangle scaleBy: aWindowScale ].
		dirtyAreas do: [ :rectangle |
			destinationForm copy: rectangle from: aBlHostRendererFormSurface form to: rectangle origin rule: Form over ].
	] ensure: [ texture unlock ].

	self present