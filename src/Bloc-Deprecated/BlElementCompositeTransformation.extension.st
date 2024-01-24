Extension { #name : #BlElementCompositeTransformation }

{ #category : #'*Bloc-Deprecated' }
BlElementCompositeTransformation >> transformations [

	self
		deprecated: 'Use #elementTransformations instead'
		transformWith: '`@receiver transformations' -> '`@receiver elementTransformations'.
	
	^ elementTransformations
]
