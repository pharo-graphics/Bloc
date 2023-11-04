Class {
	#name : 'BlEasingQuad',
	#superclass : 'BlEasing',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'interpolation' }
BlEasingQuad >> interpolate: aProgress [
	^ aProgress raisedTo: 2
]
