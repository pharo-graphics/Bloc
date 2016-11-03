translation
horizontalTranslationFor: elementBounds in: allowedBounds
	"@see BlLayoutAlignment>>#horizontalTranslationFor:in:"
	<return: #Number>
	
	^ allowedBounds width - elementBounds width + allowedBounds left - elementBounds left