Class {
	#name : #BlElementForegroundProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'foreground'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementForegroundProperty >> applyOnElement: anElement [
	(anElement respondsTo: #foreground:)
		ifTrue: [ anElement foreground: self foreground ]
]

{ #category : #testing }
BlElementForegroundProperty >> canPropagateToChildren [
	^ true
]

{ #category : #accessing }
BlElementForegroundProperty >> foreground [
	^ foreground
]

{ #category : #accessing }
BlElementForegroundProperty >> foreground: anObject [
	foreground := anObject
]
