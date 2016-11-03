*Bloc-Athens
applyEffectOnAthensCanvas: anAthensCanvas for: anElement around: aBlock

	self input applyEffectOnAthensCanvas: anAthensCanvas for: anElement around: [
		 self applyBeforeOnAthensCanvas: anAthensCanvas for: anElement.
		 aBlock value.
		 self applyAfterOnAthensCanvas: anAthensCanvas for: anElement ]