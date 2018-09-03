"
I represent a path of elements to the actual focused element.

Even if  ""parent <-> child"" connection between elements is lost due to removing we still have all the necessary information to send FocusOut events.

I am used by ${class:BlFocusProcessor}$ to properly send events
"
Class {
	#name : #BlFocusChain,
	#superclass : #DoubleLinkedList,
	#category : #'Bloc-Space-Support'
}

{ #category : #'instance creation' }
BlFocusChain class >> of: anElement [
	| aChain |
	
	aChain := self new.
	anElement withParentsDo: [ :aParent |
		aChain addFirst: aParent ].

	^ aChain
]

{ #category : #enumerating }
BlFocusChain >> leafsDo: aBlock [
	"Evaluate a given block with all leaf elements in the chain starting from the focused element in reverse order"
	| previousElementHadParent |

	previousElementHadParent := false.
	self reverseDo: [ :anElement |
		previousElementHadParent
			ifFalse: [ aBlock value: anElement ].
		previousElementHadParent := anElement value hasParent ]
]
