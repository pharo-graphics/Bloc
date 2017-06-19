updating screen
presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas
	[ 
		| pitchHolder pixels pitch destinationForm sourceForm aWindowScale dirtyAreas |
		pixels := ExternalAddress new.
		pitchHolder := FFIExternalArray externalNewType: 'int' size: 1.
		[
			texture lockPixels: pixels pitch: pitchHolder getHandle.
			pitch := pitchHolder at: 1.
		] ensure: [ pitchHolder free ].

		destinationForm := BlExternalForm extent: textureExtent depth: 32 bits: pixels.
		sourceForm := BlExternalForm extent: aBlHostRendererBufferSurface extent depth: 32 bits: aBlHostRendererBufferSurface buffer.
		
		aWindowScale := aBlHostRendererBufferSurface scaleFactor.
		dirtyAreas := aCollectionOfAreas collect: [ :aRectangle | aRectangle scaleBy: aWindowScale ].
		dirtyAreas do: [ :rectangle |
			destinationForm copy: rectangle from: sourceForm to: rectangle origin rule: Form over ].
	]
	ensure: [
		texture unlock.
	].

	self present