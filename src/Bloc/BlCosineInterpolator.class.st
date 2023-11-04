"
I am a cosinus interpolator defined by the following function:

	f(x) = cos(x)

"
Class {
	#name : 'BlCosineInterpolator',
	#superclass : 'BlInterpolator',
	#instVars : [
		'range'
	],
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'initialization' }
BlCosineInterpolator >> initialize [
	super initialize.
	
	range := 2 * Float pi
]

{ #category : 'interpolation' }
BlCosineInterpolator >> interpolate: aNumber [
	"f(x) = cos(x)"
	<return: #Number>

	^ (aNumber * self range) cos
]

{ #category : 'accessing' }
BlCosineInterpolator >> range [
	<return: #Number>

	^ range
]

{ #category : 'accessing' }
BlCosineInterpolator >> range: aNumberInRadians [
	range := aNumberInRadians
]
