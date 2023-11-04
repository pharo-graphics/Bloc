"
I am sent by BlText when a collection of strings (or one string) is inserted at some indices

"
Class {
	#name : 'BlTextStringsInserted',
	#superclass : 'Announcement',
	#instVars : [
		'strings',
		'finalIndices',
		'requestedIndices'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Events',
	#package : 'Bloc-Text',
	#tag : 'Text-Events'
}

{ #category : 'accessing' }
BlTextStringsInserted >> finalIndices [
	^ finalIndices
]

{ #category : 'accessing' }
BlTextStringsInserted >> finalIndices: anObject [
	finalIndices := anObject
]

{ #category : 'accessing' }
BlTextStringsInserted >> requestedIndices [
	^ requestedIndices
]

{ #category : 'accessing' }
BlTextStringsInserted >> requestedIndices: anObject [
	requestedIndices := anObject
]

{ #category : 'accessing' }
BlTextStringsInserted >> strings [
	^ strings
]

{ #category : 'accessing' }
BlTextStringsInserted >> strings: anObject [
	strings := anObject
]
