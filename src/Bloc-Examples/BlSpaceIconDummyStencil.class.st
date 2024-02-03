"
I am a dummy object used by `BlSpaceExamples`.
I evaluate create an icon on `BlSpaceIconDummyStencil>>#asElement|label=#selector` call.


"
Class {
	#name : 'BlSpaceIconDummyStencil',
	#superclass : 'Object',
	#instVars : [
		'block'
	],
	#category : 'Bloc-Examples-Space',
	#package : 'Bloc-Examples',
	#tag : 'Space'
}

{ #category : 'api - converting' }
BlSpaceIconDummyStencil >> asElement [
	<return: #BlElement>
	^ self block value
]

{ #category : 'api - accessing' }
BlSpaceIconDummyStencil >> block [
	^ block
]

{ #category : 'api - accessing' }
BlSpaceIconDummyStencil >> block: anObject [
	block := anObject
]
