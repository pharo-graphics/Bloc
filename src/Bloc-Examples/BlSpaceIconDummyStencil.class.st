"
I am a dummy object used by {{gtClass:BlSpaceExamples}}.
I evaluate create an icon on {{gtMethod:BlSpaceIconDummyStencil>>#asElement|label=#selector}} call.


"
Class {
	#name : 'BlSpaceIconDummyStencil',
	#superclass : 'Object',
	#instVars : [
		'block'
	],
	#category : 'Bloc-Examples-SpaceMigrated',
	#package : 'Bloc-Examples',
	#tag : 'SpaceMigrated'
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
