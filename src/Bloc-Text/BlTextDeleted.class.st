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
		'toIndex',
		'text'
	],
	#category : #'Bloc-Text-Text-Events'
}

{ #category : #'instance creation' }
BlTextDeleted class >> from: aFromIndex to: aToIndex text: aDeletedBlText [
	^ self new
		fromIndex: aFromIndex;
		toIndex: aToIndex;
		text: aDeletedBlText
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
BlTextDeleted >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
BlTextDeleted >> text: aBlText [
	text := aBlText
]

{ #category : #accessing }
BlTextDeleted >> toIndex [
	^ toIndex
]

{ #category : #accessing }
BlTextDeleted >> toIndex: anObject [
	toIndex := anObject
]
