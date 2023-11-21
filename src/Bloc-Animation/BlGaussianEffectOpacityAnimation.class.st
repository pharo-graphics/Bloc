Class {
	#name : 'BlGaussianEffectOpacityAnimation',
	#superclass : 'BlAnimation',
	#instVars : [
		'to',
		'from',
		'color',
		'width',
		'widthTransition'
	],
	#category : 'Bloc-Animation-Animation',
	#package : 'Bloc-Animation',
	#tag : 'Animation'
}

{ #category : 'pulse' }
BlGaussianEffectOpacityAnimation >> applyValue: anOpacity [

	self target effect: (BlGaussianShadowEffect
			 color: (self color alpha: anOpacity)
			 width: (self widthTransition ifTrue: [ self width * self progress ] ifFalse: [ self width ])
			 offset: 0 @ 0).
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> color [
	"Set desired opacity of an element at the end of animation"

	^ color ifNil: [ color := Color gray ]
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> color: aColor [
	"Set desired opacity of an element at the end of animation"

	color := aColor
]

{ #category : 'private - running' }
BlGaussianEffectOpacityAnimation >> initStart [

	super initStart.
	from := self target opacity
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> opacity: aNumber [
	"Set desired opacity of an element at the end of animation"

	to := aNumber
]

{ #category : 'pulse' }
BlGaussianEffectOpacityAnimation >> valueForStep: aNumber [

	^ ((to - from ) * aNumber) + from
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> width [
	"Set desired opacity "

	^ width 
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> width: aNumber [

	width := aNumber
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> widthTransition [
	"Set desired widthTransition option. if true, then width increases on each step "

	^ widthTransition ifNil: [ widthTransition := false ] 
]

{ #category : 'accessing' }
BlGaussianEffectOpacityAnimation >> widthTransition: aBoolean [
	"Set desired widthTransition option. if true, then width increases on each step "

	widthTransition := aBoolean
]
