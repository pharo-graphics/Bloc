"
Sent when one or more attributes are removed within an interval

"
Class {
	#name : 'BlTextAttributesRemoved',
	#superclass : 'Announcement',
	#instVars : [
		'fromIndex',
		'toIndex'
	],
	#category : 'Bloc-Text-Text-Events',
	#package : 'Bloc-Text',
	#tag : 'Text-Events'
}

{ #category : 'instance creation' }
BlTextAttributesRemoved class >> from: aFromIndex to: aToIndex [
	^ self new
		fromIndex: aFromIndex;
		toIndex: aToIndex
]

{ #category : 'accessing' }
BlTextAttributesRemoved >> fromIndex [
	^ fromIndex
]

{ #category : 'accessing' }
BlTextAttributesRemoved >> fromIndex: anObject [
	fromIndex := anObject
]

{ #category : 'accessing' }
BlTextAttributesRemoved >> toIndex [
	^ toIndex
]

{ #category : 'accessing' }
BlTextAttributesRemoved >> toIndex: anObject [
	toIndex := anObject
]
