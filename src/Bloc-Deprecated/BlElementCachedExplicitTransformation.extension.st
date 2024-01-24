Extension { #name : #BlElementCachedExplicitTransformation }

{ #category : #'*Bloc-Deprecated' }
BlElementCachedExplicitTransformation >> bounds [

	self
		deprecated: 'Use #boundingRectangle instead'
		transformWith: '`@receiver bounds' -> '`@receiver boundingRectangle'.

	^ boundingRectangle
]

{ #category : #'*Bloc-Deprecated' }
BlElementCachedExplicitTransformation >> transformation [

	self
		deprecated: 'Use #elementTransformation instead'
		transformWith: '`@receiver transformation' -> '`@receiver elementTransformation'.
	
	^ elementTransformation
]
