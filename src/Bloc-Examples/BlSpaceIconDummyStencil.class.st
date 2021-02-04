"
I am a dummy object used by ${class:BlSpaceExamples}$.
I evaluate create an icon on ${method:BlSpaceIconDummyStencil>>#asElement|label=#selector}$ call.

"
Class {
	#name : #BlSpaceIconDummyStencil,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'Bloc-Examples-Space'
}

{ #category : #'api - converting' }
BlSpaceIconDummyStencil >> asElement [
	<return: #BlElement>
	^ self block value
]

{ #category : #'api - accessing' }
BlSpaceIconDummyStencil >> block [
	^ block
]

{ #category : #'api - accessing' }
BlSpaceIconDummyStencil >> block: anObject [
	block := anObject
]
