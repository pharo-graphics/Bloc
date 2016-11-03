effect
applyEffectOn: anAthensCanvas for: anAtom around: aBlock

	self input applyEffectOn: anAthensCanvas for: anAtom around: [
		 self applyBeforeOn: anAthensCanvas for: anAtom.
		 aBlock value.
		 self applyAfterOn: anAthensCanvas for: anAtom ]