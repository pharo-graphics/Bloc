"
I am an abstract collection of bloc elements that can be mutated. I am used by a {{gtClass:BlElement}} to store its children.

I provide a data structure independent API for adding and removing children. I assume an index-based way of working with children. My subclasses wrap concrete data structures for storing the actual children. Bloc elements work with children only in terms of the API that I provide. Hence, I only provide a minimum API needed to work with children, instead of the full collection API.

I allow elements to optimize working with children for different scenarious. For example, an array for storing children optimises for accessing fast accesses at any position. A linked list optimize for fast adding and removing. A rope uses a balanced binary tree to support fast adding, removing and accessing, with the disadvantage of taking more memory.

## API

The following subclasses can be used to store children: 
- {{gtClass:BlChildrenArray}}: stores children using an {{gtClass:Array}} 
- {{gtClass:BlChildrenLinkedList}}: stores children using a {{gtClass:LinkedList}}  
- {{gtClass:BlChildrenOrderedCollection}}: stores children using a {{gtClass:OrderedCollection}}
- {{gtClass:BlChildrenRope}}: stores children using a {{gtClass:BlCollectionRope}}

Subclasses need to provide the implementation for methods adding and removing children.

"
Class {
	#name : 'BlChildrenCollection',
	#superclass : 'BlChildren',
	#category : 'Bloc-Basic-Children'
}

{ #category : 'children - adding' }
BlChildrenCollection >> add: anElement [
	"Adds aChild as a last one in a collection"

	self add: anElement at: self size + 1
]

{ #category : 'children - adding' }
BlChildrenCollection >> add: anElement at: anIndex [
	"Adds anElement at a given index moving existing children to the right"

	self subclassResponsibility
]

{ #category : 'children - adding' }
BlChildrenCollection >> addAll: aCollectionOfBlElement [
	"Add all elements from a given collection appending them to the end"

	self subclassResponsibility
]

{ #category : 'children - adding' }
BlChildrenCollection >> addFirst: anElement [
	"Add a given element as a first item moving all existing children to the right"

	self add: anElement at: 1
]

{ #category : 'children - removing' }
BlChildrenCollection >> remove: anElement [	
	self
		remove: anElement
		ifAbsent: [ self errorNotFound: anElement ]
]

{ #category : 'children - removing' }
BlChildrenCollection >> remove: anElement ifAbsent: anExceptionBlock [
	| anIndex |

	anIndex := self indexOf: anElement.
	anIndex isZero
		ifTrue: [ anExceptionBlock value ].

	self removeAt: anIndex
]

{ #category : 'children - removing' }
BlChildrenCollection >> removeAll: aCollectionOfBlElement [
	self subclassResponsibility
]

{ #category : 'children - removing' }
BlChildrenCollection >> removeAt: anIndex [
	self subclassResponsibility
]

{ #category : 'children - swapping' }
BlChildrenCollection >> swapAt: aChildIndex with: anotherChildIndex [
	| lesserIndex greaterIndex fristChild secondChild  | 
	aChildIndex = anotherChildIndex
		ifTrue: [ ^ self ].
		
	self
		assert: [ aChildIndex between: 1 and: self size ]
		description: [ 'Child index must be within bounds' ].
		
	self
		assert: [ anotherChildIndex between: 1 and: self size ]
		description: [ 'Child index must be within bounds' ].
		
	lesserIndex := aChildIndex min: anotherChildIndex.
	greaterIndex := aChildIndex max: anotherChildIndex.
	
	fristChild := self at: lesserIndex.
	secondChild := self at: greaterIndex.

	self removeAt: greaterIndex.
	self removeAt: lesserIndex.

	self add: secondChild at: lesserIndex.
	self add: fristChild at: greaterIndex
]
