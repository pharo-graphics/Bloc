"
I represent a path of elements to the actual focused element.

Even if  ""parent <-> child"" connection between elements is lost due to removing we still have all the necessary information to send FocusOut events.

I am used by `BlFocusProcessor` to properly send events

"
Class {
	#name : #BlFocusChain,
	#superclass : #DoubleLinkedList,
	#category : #'Bloc-Space - Events'
}

{ #category : #'instance creation' }
BlFocusChain class >> of: anElement [
	| aChain |
	
	aChain := self new.
	anElement withAllParentsDo: [ :aParent |
		aChain addFirst: aParent ].

	^ aChain
]

{ #category : #enumerating }
BlFocusChain >> deepestAttachedElementDo: aBlock ifAbsent: ifAbsentBlock [
	"Evaluate a given block with the first attached older parent of the focused element"

	self reverseDo: [ :anElement |
		(anElement isAttachedToSceneGraph and: [ anElement isFocusable ])
			ifTrue: [ ^ aBlock value: anElement ] ].
		
	^ ifAbsentBlock value
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
