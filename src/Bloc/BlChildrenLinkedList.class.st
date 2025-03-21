"
I am a holder that uses a `LinkedList` to store children of bloc elements.

Internally I maintain one single `LinkedList` instance. When children are added or removed I add or remove them from the wrapped list. 

## Examples
Examples are provided by the class `BlChildrenLinkedListExamples`

"
Class {
	#name : #BlChildrenLinkedList,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'list'
	],
	#category : #'Bloc-Basic-Children'
}

{ #category : #'children - adding' }
BlChildrenLinkedList >> add: aChild at: anIndex [
	"Adds aChild at a given index moving existing children to the right"
	| aLinkAt |
	
	anIndex = 1
		ifTrue: [
			list addFirst: aChild.
			^ self ].
	
	aLinkAt := list linkAt: anIndex - 1.
	list add: aChild afterLink: aLinkAt.
	self resetCache
]

{ #category : #'children - adding' }
BlChildrenLinkedList >> addAll: aSequenceableCollection [
	list addAll: aSequenceableCollection.
	self resetCache
]

{ #category : #'children - accessing' }
BlChildrenLinkedList >> at: anIndex [
	"Return an element at a given index"
	<return: #BlElement>

	^ list at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenLinkedList >> do: aBlock [
	list do: aBlock
]

{ #category : #initialization }
BlChildrenLinkedList >> initialize [
	super initialize.
	
	list := LinkedList new.
	self resetCache
]

{ #category : #accessing }
BlChildrenLinkedList >> name [
	^ 'Children linked list'
]

{ #category : #'children - removing' }
BlChildrenLinkedList >> removeAll: aCollectionOfBlElement [
	list removeAll: aCollectionOfBlElement.
	self resetCache
]

{ #category : #'children - removing' }
BlChildrenLinkedList >> removeAt: anIndex [
	| aLinkAt |

	aLinkAt := list linkAt: anIndex.
	list removeLink: aLinkAt.
	self resetCache
]

{ #category : #'children - accessing' }
BlChildrenLinkedList >> size [
	<return: #Number>

	^ list size
]
