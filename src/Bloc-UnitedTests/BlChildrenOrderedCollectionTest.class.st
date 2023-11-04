"
I have been automatically converted and probably manually tweaked from BlChildrenOrderedCollectionExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlChildrenOrderedCollectionTest,
	#superclass : #TestCase,
	#traits : 'TBlChildrenTest',
	#classTraits : 'TBlChildrenTest classTrait',
	#category : #'Bloc-UnitedTests-Children'
}

{ #category : #fixture }
BlChildrenOrderedCollectionTest >> fill: aNumber [

	| childrenArray |
	childrenArray := self testEmptyChildren.
	1 to: aNumber do: [ :anIndex |
	childrenArray add: (self newChildAt: anIndex) ].
	^ childrenArray
]

{ #category : #fixture }
BlChildrenOrderedCollectionTest >> newChildAt: anIndex [

	| anElement |
	anElement := BlElement new.
	anElement userData at: #index put: anIndex.
	^ anElement
]

{ #category : #fixture }
BlChildrenOrderedCollectionTest >> newChildrenCollection [

	^ BlChildrenOrderedCollection new
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testEmptyChildren [

	| theChildren |
	theChildren := self newChildrenCollection.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testFirst [

	<sampleInstance>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren first userData at: #index) equals: 1.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIfEmpty [

	| theChildren |
	theChildren := self fill: 0.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: #empty.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIfEmptyNot [

	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: theChildren.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIndexOf [

	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: (theChildren at: 1)) equals: 1.
	self assert: (theChildren indexOf: (theChildren at: 5)) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIndexOfUnknown [

	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: BlElement new) equals: 0.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIsEmpty [

	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren isEmpty.
	theChildren := self fill: 5.
	self deny: theChildren isEmpty.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIsNotEmpty [

	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren isNotEmpty not.
	theChildren := self fill: 5.
	self assert: theChildren isNotEmpty.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testLast [

	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren last userData at: #index) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testRemove [

	| theChildren indices |
	theChildren := self fill: 5.
	theChildren remove: (theChildren at: 3).
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 4.
	self assert: indices equals: #( 1 2 4 5 ).
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testRemoveAll [

	| theChildren indices |
	theChildren := self fill: 5.
	theChildren removeAll: {
			(theChildren at: 5).
			(theChildren at: 3).
			(theChildren at: 1) }.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #( 2 4 ).
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testRemoveAt [

	| theChildren indices |
	theChildren := self fill: 5.
	theChildren removeAt: 5.
	theChildren removeAt: 3.
	theChildren removeAt: 1.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #( 2 4 ).
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testSecond [

	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren second userData at: #index) equals: 2.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testSize [

	| theChildren |
	theChildren := self fill: 5.
	self assert: theChildren size equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testSizeEmpty [

	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren size equals: 0.
	^ theChildren
]
