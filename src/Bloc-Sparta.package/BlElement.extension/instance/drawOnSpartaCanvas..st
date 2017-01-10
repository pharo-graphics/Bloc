*Bloc-Sparta
drawOnSpartaCanvas: aCanvas

	self effect
		applyEffectOnSpartaCanvas: aCanvas
		for: self
		around: [ 
			self drawPathOnSpartaCanvas: aCanvas.
			self drawChildrenOnSpartaCanvas: aCanvas ]