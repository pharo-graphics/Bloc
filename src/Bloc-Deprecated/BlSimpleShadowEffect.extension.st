Extension { #name : #BlSimpleShadowEffect }

{ #category : #'*Bloc-Deprecated' }
BlSimpleShadowEffect class >> default [

	self
		deprecated: 'Use #new instead'
		transformWith: '`@receiver default' -> '`@receiver new'.

	^ self color: (Color black alpha: 0.3) offset: 10 @ 10
]
