Class {
	#name : #BlEasingBounceIn,
	#superclass : #BlEasingBaseBounce,
	#category : #'Bloc-Basic-Interpolators'
}

{ #category : #interpolation }
BlEasingBounceIn >> interpolate: aProgress [
	^ self computeBounce: aProgress
]
