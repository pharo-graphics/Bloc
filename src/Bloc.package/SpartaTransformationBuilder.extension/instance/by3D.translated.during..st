*Bloc-Core
by3D: aBlElementTransform translated: aPoint during: aBlock
	| aTransformedCanvas |
	
	aTransformedCanvas := self canvas similar: 200@400.
	aBlock value: aTransformedCanvas.

	self canvas stroke
			path: self canvas clip globalBounds;
			paint: Color black;
			draw.

	self during: [
		self translateBy: aPoint + (0@0).
		self apply.
		
		self
			drawSurface: aTransformedCanvas surface
			transformed: aBlElementTransform matrix ]