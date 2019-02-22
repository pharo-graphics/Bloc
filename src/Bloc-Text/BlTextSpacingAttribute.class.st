Class {
	#name : #BlTextSpacingAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'spacing'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlTextSpacingAttribute class >> spacing: aNumber [
	^ self new spacing: aNumber
]

{ #category : #comparing }
BlTextSpacingAttribute >> equals: aTextAttribute [
	^ self spacing = aTextAttribute spacing
]

{ #category : #comparing }
BlTextSpacingAttribute >> hash [
	^ self class hash bitXor: self spacing hash
]

{ #category : #accessing }
BlTextSpacingAttribute >> spacing [
	^ spacing
]

{ #category : #accessing }
BlTextSpacingAttribute >> spacing: anObject [
	spacing := anObject
]
