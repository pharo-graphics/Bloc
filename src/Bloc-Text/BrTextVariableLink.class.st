Class {
	#name : #BrTextVariableLink,
	#superclass : #BrTextLinkAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BrTextVariableLink class >> variableName: aString [
	^ self new
]

{ #category : #comparing }
BrTextVariableLink >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BrTextVariableLink >> hash [
	^ self class hash
]
