*Bloc-Sparta
applyEffectOnSpartaCanvas: anSpartaCanvas for: anElement around: aBlock
	
	self applyBeforeOnSpartaCanvas: anSpartaCanvas for: anElement.
	aBlock value.
	self applyAfterOnSpartaCanvas: anSpartaCanvas for: anElement