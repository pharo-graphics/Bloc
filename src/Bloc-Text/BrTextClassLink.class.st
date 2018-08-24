Class {
	#name : #BrTextClassLink,
	#superclass : #BrTextLinkAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BrTextClassLink class >> class: aClass [
	^ self new
]

{ #category : #accessing }
BrTextClassLink class >> className: aString [
	^ self new
]

{ #category : #comparing }
BrTextClassLink >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BrTextClassLink >> hash [
	^ self class hash
]
