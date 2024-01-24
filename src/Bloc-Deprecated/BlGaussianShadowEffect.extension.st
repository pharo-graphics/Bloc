Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Deprecated' }
BlGaussianShadowEffect class >> default [

	self
		deprecated: 'Use #new instead'
		transformWith: '`@receiver default' -> '`@receiver new'.
	
	^ self
		color: (Color black alpha: 0.3)
		width: 15
		offset: 10@20
]
