Class {
	#name : #BlTextMethodLink,
	#superclass : #BlTextLinkAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlTextMethodLink class >> selector: aSymbol [
	^ self new
]

{ #category : #comparing }
BlTextMethodLink >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BlTextMethodLink >> hash [
	^ self class hash
]
