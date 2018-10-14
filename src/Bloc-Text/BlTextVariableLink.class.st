Class {
	#name : #BlTextVariableLink,
	#superclass : #BlTextLinkAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlTextVariableLink class >> variableName: aString [
	^ self new
]

{ #category : #comparing }
BlTextVariableLink >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BlTextVariableLink >> hash [
	^ self class hash
]
