"
I am sent by BlText when a string is inserted at some index.

[[[
| anAnnouncement |			
anAnnouncement := BlTextStringInserted string: 'Haba' at: 2
]]]
"
Class {
	#name : #BlTextStringInserted,
	#superclass : #Announcement,
	#instVars : [
		'string',
		'index'
	],
	#category : 'Bloc-Text-Text-Events'
}

{ #category : #'instance creation' }
BlTextStringInserted class >> string: aString at: anIndex [
	^ self new
		string: aString;
		index: anIndex
]

{ #category : #accessing }
BlTextStringInserted >> index [
	^ index
]

{ #category : #accessing }
BlTextStringInserted >> index: anObject [
	index := anObject
]

{ #category : #accessing }
BlTextStringInserted >> string [
	^ string
]

{ #category : #accessing }
BlTextStringInserted >> string: anObject [
	string := anObject
]
