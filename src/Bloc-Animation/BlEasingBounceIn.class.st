Class {
	#name : #BlEasingBounceIn,
	#superclass : #BlEasingBaseBounce,
	#category : 'Bloc-Animation-Interpolators'
}

{ #category : #interpolation }
BlEasingBounceIn >> interpolate: aProgress [
	^ self computeBounce: aProgress
]
