Class {
	#name : 'BlElementLayoutProperty',
	#superclass : 'BlElementProperty',
	#instVars : [
		'layout'
	],
	#package : 'Bloc',
	#tag : 'Basic-Properties'
}

{ #category : 'comparing' }
BlElementLayoutProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ layout = anObject layout
]

{ #category : 'api - property' }
BlElementLayoutProperty >> applyOnElement: anElement [
	anElement layout: self layout
]

{ #category : 'api - property' }
BlElementLayoutProperty >> cleanUpOnElement: anElement [
	anElement layout: anElement defaultLayout
]

{ #category : 'comparing' }
BlElementLayoutProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ layout hash
]

{ #category : 'accessing' }
BlElementLayoutProperty >> layout [
	^ layout
]

{ #category : 'accessing' }
BlElementLayoutProperty >> layout: anObject [
	layout := anObject
]
