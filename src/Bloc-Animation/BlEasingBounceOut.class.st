Class {
	#name : #BlEasingBounceOut,
	#superclass : #BlEasingBaseBounce,
	#category : 'Bloc-Animation-Interpolators'
}

{ #category : #interpolation }
BlEasingBounceOut >> interpolate: aProgress [
	^ 1-(self computeBounce:(1-aProgress))
]
