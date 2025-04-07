Class {
	#name : #BlTextAnnouncer,
	#superclass : #Announcer,
	#category : #'Bloc-Text-Text'
}

{ #category : #copying }
BlTextAnnouncer >> postCopy [
	super postCopy.
	registry := registry copy.
]
