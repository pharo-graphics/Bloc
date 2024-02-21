Class {
	#name : #BlColorTransition,
	#superclass : #BlTransition,
	#category : #'Bloc-Animation-Animation'
}

{ #category : #pulse }
BlColorTransition >> valueForStep: aNumber [

	| r g b a |
	r := (to red - from red) * aNumber + from red.
	g := (to green - from green) * aNumber + from green.
	b := (to blue - from blue) * aNumber + from blue.
	a := (to alpha - from alpha) * aNumber + from alpha.
	
	^ Color r: r g: g b: b alpha: a
]
