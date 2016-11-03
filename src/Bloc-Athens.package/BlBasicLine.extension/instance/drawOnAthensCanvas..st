*Bloc-Athens-drawing
drawOnAthensCanvas: aCanvas
	aCanvas pathTransform restoreAfter: [
		self effect applyEffectOnAthensCanvas: aCanvas for: self around: [ 
			self drawPathOnAthensCanvas: aCanvas]]