Class {
	#name : #BlColorTransition,
	#superclass : #BlTransition,
	#category : #'Bloc-Animation-Animation'
}

{ #category : #'api - interpolation' }
BlColorTransition >> interpolate: aFromColor to: aToColor at: aDelta [

	| r g b a delta |
	delta := aDelta min: 1 max: 0.

	r := (aToColor red - aFromColor red) * delta + aFromColor red.
	g := (aToColor green - aFromColor green) * delta + aFromColor green.
	b := (aToColor blue - aFromColor blue) * delta + aFromColor blue.
	a := (aToColor alpha - aFromColor alpha) * delta + aFromColor alpha.
	
	^ Color r: r g: g b: b alpha: a
]

{ #category : #pulse }
BlColorTransition >> valueForStep: aDelta [

	^ self interpolate: from to: to at: aDelta
]
