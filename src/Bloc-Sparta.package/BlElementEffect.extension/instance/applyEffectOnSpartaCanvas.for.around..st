*Bloc-Sparta
applyEffectOnSpartaCanvas: anSpartaCanvas for: anElement around: aBlock

	self input applyEffectOnSpartaCanvas: anSpartaCanvas for: anElement around: [
		 self applyBeforeOnSpartaCanvas: anSpartaCanvas for: anElement.
		 aBlock value.
		 self applyAfterOnSpartaCanvas: anSpartaCanvas for: anElement ]