"
Used to allow creation of items of different types in infinite element
"
Class {
	#name : #BlInfiniteItemType,
	#superclass : #Object,
	#classVars : [
		'invalid'
	],
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #'class initialization' }
BlInfiniteItemType class >> initialize [
	super initialize.
	
	invalid := BlInfiniteInvalidItemType new
]

{ #category : #instances }
BlInfiniteItemType class >> invalid [
	^ invalid
]

{ #category : #comparing }
BlInfiniteItemType >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
BlInfiniteItemType >> hash [
	^ self class hash
]
