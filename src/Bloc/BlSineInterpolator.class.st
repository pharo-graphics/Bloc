"
I am a cosinus interpolator defined by the following function:

	f(x) = sin(x)

"
Class {
	#name : 'BlSineInterpolator',
	#superclass : 'BlInterpolator',
	#instVars : [
		'range'
	],
	#category : 'Bloc-Basic-Interpolators'
}

{ #category : 'initialization' }
BlSineInterpolator >> initialize [
	super initialize.
	
	range := 2 * Float pi
]

{ #category : 'interpolation' }
BlSineInterpolator >> interpolate: aNumber [
	"f(x) = sin(x)"
	<return: #Number>

	^ (aNumber * self range) sin
]

{ #category : 'accessing' }
BlSineInterpolator >> range [
	<return: #Number>

	^ range
]

{ #category : 'accessing' }
BlSineInterpolator >> range: aNumberInRadians [
	range := aNumberInRadians
]
