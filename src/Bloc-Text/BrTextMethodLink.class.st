Class {
	#name : #BrTextMethodLink,
	#superclass : #BrTextLinkAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BrTextMethodLink class >> selector: aSymbol [
	^ self new
]

{ #category : #comparing }
BrTextMethodLink >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BrTextMethodLink >> hash [
	^ self class hash
]
