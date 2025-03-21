"
I am a holder that uses an `BlCollectionRope` to store children of bloc elements.

Internally I maintain one single `BlCollectionRope` intance. When children are added or removed I add or remove them from the wrapped rope. 

## Examples
Examples are provided by the class `BlChildrenRopeExamples`

"
Class {
	#name : #BlChildrenRope,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'rope'
	],
	#category : #'Bloc-Basic-Children'
}

{ #category : #'children - adding' }
BlChildrenRope >> add: aChild at: anIndex [
	"Adds aChild at a given index moving existing children to the right"

	rope := rope insertItems: { aChild } at: anIndex - 1.
	self resetCache
]

{ #category : #'children - adding' }
BlChildrenRope >> addAll: aSequenceableCollection [
	rope := rope insertItems: aSequenceableCollection at: rope size.
	self resetCache
]

{ #category : #'children - accessing' }
BlChildrenRope >> at: anIndex [
	"Return an element at a given index"
	<return: #BlElement>

	^ rope at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenRope >> do: aBlock [
	rope do: aBlock
]

{ #category : #initialization }
BlChildrenRope >> initialize [
	super initialize.
	
	rope := BlCollectionRope collection: #() 
]

{ #category : #accessing }
BlChildrenRope >> name [
	^ 'Children rope'
]

{ #category : #'children - removing' }
BlChildrenRope >> removeAll: aCollectionOfBlElement [
	aCollectionOfBlElement do: [ :aChild | self remove: aChild ].
	self resetCache
]

{ #category : #'children - removing' }
BlChildrenRope >> removeAt: anIndex [
	rope := rope delete: anIndex - 1 to: anIndex.
	self resetCache
]

{ #category : #'children - accessing' }
BlChildrenRope >> size [
	<return: #Number>

	^ rope size
]
