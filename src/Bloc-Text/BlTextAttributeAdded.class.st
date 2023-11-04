Class {
	#name : 'BlTextAttributeAdded',
	#superclass : 'Announcement',
	#instVars : [
		'attribute',
		'fromIndex',
		'toIndex'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Events',
	#package : 'Bloc-Text',
	#tag : 'Text-Events'
}

{ #category : 'instance creation' }
BlTextAttributeAdded class >> attribute: aTextAttribute from: aFromIndex to: aToIndex [
	^ self new
		attribute: aTextAttribute;
		fromIndex: aFromIndex;
		toIndex: aToIndex
]

{ #category : 'accessing' }
BlTextAttributeAdded >> attribute [
	^ attribute
]

{ #category : 'accessing' }
BlTextAttributeAdded >> attribute: anObject [
	attribute := anObject
]

{ #category : 'accessing' }
BlTextAttributeAdded >> fromIndex [
	^ fromIndex
]

{ #category : 'accessing' }
BlTextAttributeAdded >> fromIndex: anObject [
	fromIndex := anObject
]

{ #category : 'accessing' }
BlTextAttributeAdded >> toIndex [
	^ toIndex
]

{ #category : 'accessing' }
BlTextAttributeAdded >> toIndex: anObject [
	toIndex := anObject
]
