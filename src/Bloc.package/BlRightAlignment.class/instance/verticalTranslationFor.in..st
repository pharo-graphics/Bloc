translation
verticalTranslationFor: elementBounds in: allowedBounds
	"@see BlLayoutAlignment>>#verticalTranslationFor:in:"
	<return: #Number>
	
	^ allowedBounds height - elementBounds height + allowedBounds top - elementBounds top