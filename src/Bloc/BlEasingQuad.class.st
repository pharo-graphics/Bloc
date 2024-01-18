Class {
	#name : #BlEasingQuad,
	#superclass : #BlEasing,
	#category : #'Bloc-Basic-Interpolators'
}

{ #category : #interpolation }
BlEasingQuad >> interpolate: aProgress [
	^ aProgress raisedTo: 2
]
