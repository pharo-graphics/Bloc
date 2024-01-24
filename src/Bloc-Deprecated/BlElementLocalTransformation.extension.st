Extension { #name : #BlElementLocalTransformation }

{ #category : #'*Bloc-Deprecated' }
BlElementLocalTransformation >> transformation [

	self
		deprecated: 'Use #affineTransformation instead'
		transformWith: '`@receiver transformation' -> '`@receiver affineTransformation'.
	
	^ affineTransformation
]
