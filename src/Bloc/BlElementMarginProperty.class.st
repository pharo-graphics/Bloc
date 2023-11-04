Class {
	#name : 'BlElementMarginProperty',
	#superclass : 'BlElementProperty',
	#instVars : [
		'margin'
	],
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'comparing' }
BlElementMarginProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ margin = anObject margin
]

{ #category : 'api - property' }
BlElementMarginProperty >> applyOnElement: anElement [
	anElement margin: self margin
]

{ #category : 'comparing' }
BlElementMarginProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ margin hash
]

{ #category : 'accessing' }
BlElementMarginProperty >> margin [
	^ margin
]

{ #category : 'accessing' }
BlElementMarginProperty >> margin: anObject [
	margin := anObject
]
