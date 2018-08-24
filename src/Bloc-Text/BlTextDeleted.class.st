"
I am sent by BlText when a piece of text defined by an index interval is deleted.

[[[
| anAnnouncement |			
anAnnouncement := BlTextDeleted from: 2 to: 5
]]]
"
Class {
	#name : #BlTextDeleted,
	#superclass : #Announcement,
	#instVars : [
		'fromIndex',
		'toIndex'
	],
	#category : 'Bloc-Text-Text-Events'
}

{ #category : #'instance creation' }
BlTextDeleted class >> from: aFromIndex to: aToIndex [
	^ self new
		fromIndex: aFromIndex;
		toIndex: aToIndex
]

{ #category : #accessing }
BlTextDeleted >> fromIndex [
	^ fromIndex
]

{ #category : #accessing }
BlTextDeleted >> fromIndex: anObject [
	fromIndex := anObject
]

{ #category : #accessing }
BlTextDeleted >> toIndex [
	^ toIndex
]

{ #category : #accessing }
BlTextDeleted >> toIndex: anObject [
	toIndex := anObject
]
