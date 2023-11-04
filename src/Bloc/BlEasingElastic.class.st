Class {
	#name : 'BlEasingElastic',
	#superclass : 'BlEasing',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'interpolation' }
BlEasingElastic >> interpolate: aProgress [
	^ (2 raisedTo: (10 * (aProgress - 1))) * ((20 * Float pi * 1.5 / 3 * aProgress) cos)
]
