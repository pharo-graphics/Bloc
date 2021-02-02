Class {
	#name : #BlElementForegroundProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'foreground'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementForegroundProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ foreground = anObject foreground
]

{ #category : #'api - property' }
BlElementForegroundProperty >> applyOnElement: anElement [
	(anElement respondsTo: #foreground:)
		ifTrue: [ anElement foreground: self foreground ]
]

{ #category : #accessing }
BlElementForegroundProperty >> foreground [
	^ foreground
]

{ #category : #accessing }
BlElementForegroundProperty >> foreground: anObject [
	foreground := anObject
]

{ #category : #comparing }
BlElementForegroundProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ foreground hash
]
