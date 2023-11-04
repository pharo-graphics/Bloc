Class {
	#name : 'BlEasingBounceIn',
	#superclass : 'BlEasingBaseBounce',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'interpolation' }
BlEasingBounceIn >> interpolate: aProgress [
	^ self computeBounce: aProgress
]
