*Bloc-Sparta
applyEffectOnSpartaCanvas: anSpartaCanvas for: anElement around: aBlock
	
	self applyBeforeOnSpartaCanvas: anSpartaCanvas for: anElement.
	
	anSpartaCanvas layer
		during: [
			aBlock value.
			anSpartaCanvas fill
				path: (self clipOutPathFor: anElement);
				paint: Color white;
				composeDestOut;
				draw ].

	self applyAfterOnSpartaCanvas: anSpartaCanvas for: anElement