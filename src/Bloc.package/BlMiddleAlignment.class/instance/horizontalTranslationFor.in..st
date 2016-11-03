translation
horizontalTranslationFor: elementBounds in: allowedBounds
	"@see BlLayoutAlignment>>#horizontalTranslationFor:in:"
	<return: #Number>
	
	^ (allowedBounds width - elementBounds width) / 2.0 + allowedBounds left - elementBounds left