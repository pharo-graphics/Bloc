Class {
	#name : #BlEasingQuad,
	#superclass : #BlEasing,
	#category : 'Bloc-Animation-Interpolators'
}

{ #category : #interpolation }
BlEasingQuad >> interpolate: aProgress [
	^ aProgress raisedTo: 2
]
