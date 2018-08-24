Class {
	#name : #BlChildrenLinkedList,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'list'
	],
	#category : 'Bloc-Basic-Children'
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
	list add: aChild afterLink: aLinkAt
]

{ #category : #'children - adding' }
BlChildrenLinkedList >> addAll: aSequenceableCollection [
	list addAll: aSequenceableCollection
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
	
	list := LinkedList new
]

{ #category : #accessing }
BlChildrenLinkedList >> name [
	^ 'Children linked list'
]

{ #category : #'children - removing' }
BlChildrenLinkedList >> removeAll: aCollectionOfBlElement [
	list removeAll: aCollectionOfBlElement
]

{ #category : #'children - removing' }
BlChildrenLinkedList >> removeAt: anIndex [
	| aLinkAt |

	aLinkAt := list linkAt: anIndex.
	list removeLink: aLinkAt
]

{ #category : #'children - accessing' }
BlChildrenLinkedList >> size [
	<return: #Number>

	^ list size
]
