"
I am an item type represented by its name
"
Class {
	#name : #BlInfiniteNamedItemType,
	#superclass : #BlInfiniteItemType,
	#instVars : [
		'name'
	],
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #'instance creation' }
BlInfiniteNamedItemType class >> named: aString [
	^ self new name: aString
]

{ #category : #comparing }
BlInfiniteNamedItemType >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	(anObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ anObject name = self name
]

{ #category : #comparing }
BlInfiniteNamedItemType >> hash [
	^ self name hash
]

{ #category : #initialization }
BlInfiniteNamedItemType >> initialize [
	super initialize.
	
	name := #unknown
]

{ #category : #accessing }
BlInfiniteNamedItemType >> name [
	^ name
]

{ #category : #accessing }
BlInfiniteNamedItemType >> name: anObject [
	name := anObject
]
