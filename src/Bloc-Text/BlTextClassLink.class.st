Class {
	#name : #BlTextClassLink,
	#superclass : #BlTextLinkAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlTextClassLink class >> class: aClass [
	^ self new
]

{ #category : #accessing }
BlTextClassLink class >> className: aString [
	^ self new
]

{ #category : #comparing }
BlTextClassLink >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BlTextClassLink >> hash [
	^ self class hash
]
