Class {
	#name : #BlParentChain,
	#superclass : #DoubleLinkedList,
	#category : #'Bloc-Space-Support'
}

{ #category : #'instance creation' }
BlParentChain class >> of: anElement [
	| aChain |
	
	aChain := self new.
	anElement withAllParentsDo: [ :aParent |
		aChain addFirst: aParent ].

	^ aChain
]
