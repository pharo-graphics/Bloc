drawing
drawOn: aCanvas
	aCanvas pathTransform restoreAfter: [
		self effect applyEffectOn: aCanvas for: self around: [ 
			self drawPathOn: aCanvas.
			self drawChildrenOn: aCanvas]]