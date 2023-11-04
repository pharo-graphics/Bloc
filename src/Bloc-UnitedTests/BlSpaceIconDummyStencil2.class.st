Class {
	#name : 'BlSpaceIconDummyStencil2',
	#superclass : 'Object',
	#instVars : [
		'block'
	],
	#category : 'Bloc-UnitedTests-Space',
	#package : 'Bloc-UnitedTests',
	#tag : 'Space'
}

{ #category : 'api - converting' }
BlSpaceIconDummyStencil2 >> asElement [
	<return: #BlElement>
	^ self block value
]

{ #category : 'api - accessing' }
BlSpaceIconDummyStencil2 >> block [
	^ block
]

{ #category : 'api - accessing' }
BlSpaceIconDummyStencil2 >> block: anObject [
	block := anObject
]
