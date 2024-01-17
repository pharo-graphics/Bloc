Class {
	#name : 'BlEasingBounceIn',
	#superclass : 'BlEasingBaseBounce',
	#category : 'Bloc-Basic-Interpolators',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'interpolation' }
BlEasingBounceIn >> interpolate: aProgress [
	^ self computeBounce: aProgress
]
