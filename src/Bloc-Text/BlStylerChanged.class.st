Class {
	#name : #BlStylerChanged,
	#superclass : #Announcement,
	#instVars : [
		'styler'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlStylerChanged >> styler [
	^ styler
]

{ #category : #accessing }
BlStylerChanged >> styler: anObject [
	styler := anObject
]
