Class {
	#name : 'BlTextSpacingAttribute',
	#superclass : 'BlTextAttribute',
	#instVars : [
		'spacing'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : 'instance creation' }
BlTextSpacingAttribute class >> spacing: aNumber [
	^ self new spacing: aNumber
]

{ #category : 'comparing' }
BlTextSpacingAttribute >> equals: anAnotherAttribute [
	^ self spacing = anAnotherAttribute spacing
]

{ #category : 'comparing' }
BlTextSpacingAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self spacing hash
]

{ #category : 'accessing' }
BlTextSpacingAttribute >> spacing [
	^ spacing
]

{ #category : 'accessing' }
BlTextSpacingAttribute >> spacing: anObject [
	spacing := anObject
]
