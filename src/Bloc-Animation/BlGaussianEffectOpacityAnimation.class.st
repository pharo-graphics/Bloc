Class {
	#name : #BlGaussianEffectOpacityAnimation,
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
BlGaussianEffectOpacityAnimation >> applyValue: anOpacity [

	self target effect: (BlGaussianShadowEffect
			 color: (self color alpha: anOpacity)
			 width: self width
			 offset: 0 @ 0).
]

{ #category : #accessing }
BlGaussianEffectOpacityAnimation >> color [
	"Set desired opacity of an element at the end of animation"

	^ color ifNil: [ color := Color gray ]
]

{ #category : #accessing }
BlGaussianEffectOpacityAnimation >> color: aColor [
	"Set desired opacity of an element at the end of animation"

	color := aColor
]

{ #category : #'private - running' }
BlGaussianEffectOpacityAnimation >> initStart [

	super initStart.
	from := self target opacity
]

{ #category : #accessing }
BlGaussianEffectOpacityAnimation >> opacity: aNumber [
	"Set desired opacity of an element at the end of animation"

	to := aNumber
]

{ #category : #pulse }
BlGaussianEffectOpacityAnimation >> valueForStep: aNumber [

	^ ((to - from ) * aNumber) + from
]

{ #category : #accessing }
BlGaussianEffectOpacityAnimation >> width [
	"Set desired opacity "

	^ width 
]

{ #category : #accessing }
BlGaussianEffectOpacityAnimation >> width: aNumber [

	width := aNumber
]
