geometry
spaceExtent: anExtent

	self resizeDuring: [
		self spaceExtent = anExtent
			ifFalse: [
				| aDelta |
				"we compute decorations extent first"
				aDelta := self fullBounds extent - spaceForm extent.
				super extent: anExtent + aDelta ] ]