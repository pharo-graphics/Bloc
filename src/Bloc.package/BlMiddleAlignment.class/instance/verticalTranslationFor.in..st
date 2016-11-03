translation
verticalTranslationFor: elementBounds in: allowedBounds
	"@see BlLayoutAlignment>>#verticalTranslationFor:in:"
	<return: #Number>
	
	^ (allowedBounds height - elementBounds height) / 2.0 + allowedBounds top - elementBounds top