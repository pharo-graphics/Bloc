transformations
translateBy: aVector
	self addTransformation: (BlTranslationTransformation new translation: aVector asBlocVector)