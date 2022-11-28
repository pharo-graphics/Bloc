"
I gradually change the opacity of a `BlElement` from its initial value until a specified opacity (see my accessing protocol).

"
Class {
	#name : #BlOpacityAnimation,
	#superclass : #BlAnimation,
	#instVars : [
		'to',
		'from'
	],
	#category : #'Bloc-Animation-Animation'
}

{ #category : #pulse }
BlOpacityAnimation >> applyValue: aValue [

	self target opacity: aValue
]

{ #category : #pulse }
BlOpacityAnimation >> initStart [

	super initStart.
	from := self target opacity
]

{ #category : #accessing }
BlOpacityAnimation >> opacity: aNumber [
	"Set desired opacity of an element at the end of animation"

	to := aNumber
]

{ #category : #pulse }
BlOpacityAnimation >> valueForStep: aDelta [

	^ ((to - from ) * aDelta) + from
]
