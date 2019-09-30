Class {
	#name : #BlParentChain,
	#superclass : #DoubleLinkedList,
	#category : #'Bloc-Space - Support'
}

{ #category : #'instance creation' }
BlParentChain class >> of: anElement [
	| aChain |
	
	aChain := self new.
	anElement withAllParentsDo: [ :aParent |
		aChain addFirst: aParent ].

	^ aChain
]

{ #category : #'as yet unclassified' }
BlParentChain >> gtInspectorElementsIn: aComposite [
	<gtInspectorPresentationOrder: 10>
	
	^ aComposite fastList
		title: 'Elements';
		display: [ self asArray ]
]
