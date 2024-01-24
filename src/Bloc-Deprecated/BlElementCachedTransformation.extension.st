Extension { #name : #BlElementCachedTransformation }

{ #category : #'*Bloc-Deprecated' }
BlElementCachedTransformation >> bounds: aRectangle [
	"The actual transformation matrix may depends on the element bounds due to
	potential non zero transformation origin.
	This allows cached transformation to recompute the transformation matrix when bounds change"

	self
		deprecated: 'Use #boundingRectangle: instead'
		transformWith: '`@receiver bounds: `@arg' -> '`@receiver boundingRectangle: `@arg'.

	self boundingRectangle: aRectangle
]
