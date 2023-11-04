Class {
	#name : #BlSpaceIconDummyStencil2,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#package : 'Bloc',
	#tag : 'UnitedTests-Space'
}

{ #category : #'api - converting' }
BlSpaceIconDummyStencil2 >> asElement [
	<return: #BlElement>
	^ self block value
]

{ #category : #'api - accessing' }
BlSpaceIconDummyStencil2 >> block [
	^ block
]

{ #category : #'api - accessing' }
BlSpaceIconDummyStencil2 >> block: anObject [
	block := anObject
]
