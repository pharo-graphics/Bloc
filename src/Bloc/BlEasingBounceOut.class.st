Class {
	#name : 'BlEasingBounceOut',
	#superclass : 'BlEasingBaseBounce',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'interpolation' }
BlEasingBounceOut >> interpolate: aProgress [
	^ 1-(self computeBounce:(1-aProgress))
]
