Class {
	#name : #BlGaussianEffectAnimation,
	#superclass : #BlAnimation,
	#instVars : [
		'to',
		'from',
		'color',
		'width'
	],
	#category : #'Bloc-Animation-Animation'
}

{ #category : #pulse }
BlGaussianEffectAnimation >> applyValue: anOpacity [

	self target effect: (BlGaussianShadowEffect
			 color: (self color alpha: anOpacity)
			 width: self width
			 offset: 0 @ 0).
]

{ #category : #accessing }
BlGaussianEffectAnimation >> color [
	"Set desired opacity of an element at the end of animation"

	^ color ifNil: [ color := Color gray ]
]

{ #category : #accessing }
BlGaussianEffectAnimation >> color: aColor [
	"Set desired opacity of an element at the end of animation"

	color := aColor
]

{ #category : #'private - running' }
BlGaussianEffectAnimation >> initStart [

	super initStart.
	from := self target opacity
]

{ #category : #accessing }
BlGaussianEffectAnimation >> opacity: aNumber [
	"Set desired opacity of an element at the end of animation"

	to := aNumber
]

{ #category : #pulse }
BlGaussianEffectAnimation >> valueForStep: aNumber [

	^ ((to - from ) * aNumber) + from
]

{ #category : #accessing }
BlGaussianEffectAnimation >> width [
	"Set desired opacity "

	^ width 
]

{ #category : #accessing }
BlGaussianEffectAnimation >> width: aNumber [

	width := aNumber
]
