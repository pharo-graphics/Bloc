"
I am a mutable collection of children with an ability to add and remove them.

I am data structure independent. My subclasses implement api to use concrete data structures to store children, such as array, rope or possibly a quadtree
"
Class {
	#name : #BlChildrenCollection,
	#superclass : #BlChildren,
	#category : 'Bloc-Basic-Children'
}

{ #category : #'children - adding' }
BlChildrenCollection >> add: anElement [
	"Adds aChild as a last one in a collection"

	self add: anElement at: self size + 1
]

{ #category : #'children - adding' }
BlChildrenCollection >> add: anElement at: anIndex [
	"Adds anElement at a given index moving existing children to the right"

	self subclassResponsibility
]

{ #category : #'children - adding' }
BlChildrenCollection >> addAll: aCollectionOfBlElement [
	"Add all elements from a given collection appending them to the end"

	self subclassResponsibility
]

{ #category : #'children - adding' }
BlChildrenCollection >> addFirst: anElement [
	"Add a given element as a first item moving all existing children to the right"

	self add: anElement at: 1
]

{ #category : #'children - removing' }
BlChildrenCollection >> remove: anElement [
	| anIndex |

	anIndex := self indexOf: anElement.
	anIndex isZero
		ifTrue: [ self errorNotFound: anElement ].
		
	self removeAt: anIndex
]

{ #category : #'children - removing' }
BlChildrenCollection >> removeAll: aCollectionOfBlElement [
	self subclassResponsibility
]

{ #category : #'children - removing' }
BlChildrenCollection >> removeAt: anIndex [
	self subclassResponsibility
]
