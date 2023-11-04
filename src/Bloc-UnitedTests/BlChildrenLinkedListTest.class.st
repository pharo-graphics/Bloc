"
I have been automatically converted and probably manually tweaked from BlChildrenLinkedListExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlChildrenLinkedListTest,
	#superclass : #TestCase,
	#traits : 'TBlChildrenTest',
	#classTraits : 'TBlChildrenTest classTrait',
	#category : 'Bloc-UnitedTests-Children'
}

{ #category : #fixture }
BlChildrenLinkedListTest >> fill: aNumber [
	| childrenArray |
	childrenArray := self testEmptyChildren.
	1 to: aNumber do: [ :anIndex | childrenArray add: (self newChildAt: anIndex) ].
	^ childrenArray
]

{ #category : #fixture }
BlChildrenLinkedListTest >> newChildAt: anIndex [
	| anElement |
	anElement := BlElement new.
	anElement userData at: #index put: anIndex.
	^ anElement
]

{ #category : #fixture }
BlChildrenLinkedListTest >> newChildrenCollection [
	^ BlChildrenLinkedList new
]

{ #category : #tests }
BlChildrenLinkedListTest >> testAdd [
	
	| theChildren indices |
	theChildren := self testEmptyChildren.
	theChildren add: (self newChildAt: 1).
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 1.
	self assert: indices equals: #(1).
	theChildren add: (self newChildAt: 2).
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #(1 2).
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testAddAt [
	
	| theChildren indices |
	theChildren := self testEmptyChildren.
	theChildren add: (self newChildAt: 1) at: 1.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 1.
	self assert: indices equals: #(1).
	theChildren add: (self newChildAt: 2) at: 1.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #(2 1).
	theChildren add: (self newChildAt: 3) at: 2.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 3.
	self assert: indices equals: #(2 3 1).
	theChildren add: (self newChildAt: 4) at: 4.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 4.
	self assert: indices equals: #(2 3 1 4).
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testAsArray [
	
	| theChildren indices |
	theChildren := self fill: 5.
	indices := theChildren asArray
		collect: [ :each | each userData at: #index ].
	self assert: indices equals: #(1 2 3 4 5).
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testAsArrayEmpty [
	
	| theChildren indices |
	theChildren := self testEmptyChildren.
	indices := theChildren asArray
		collect: [ :each | each userData at: #index ].
	self assert: indices equals: #().
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testAt [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: ((theChildren at: 1) userData at: #index) equals: 1.
	self assert: ((theChildren at: 2) userData at: #index) equals: 2.
	self assert: ((theChildren at: 3) userData at: #index) equals: 3.
	self assert: ((theChildren at: 4) userData at: #index) equals: 4.
	self assert: ((theChildren at: 5) userData at: #index) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testAtIfAbsent [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: ((theChildren at: 1) userData at: #index) equals: 1.
	self assert: ((theChildren at: 3) userData at: #index) equals: 3.
	self assert: ((theChildren at: 5) userData at: #index) equals: 5.
	self
		assert:
			((theChildren
				at: 0
				ifAbsent: [ | anElement |
					anElement := BlElement new.
					anElement userData at: #index put: 0.
					anElement ]) userData at: #index)
		equals: 0.
	self
		assert:
			((theChildren
				at: 10
				ifAbsent: [ | anElement |
					anElement := BlElement new.
					anElement userData at: #index put: 10.
					anElement ]) userData at: #index)
		equals: 10.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testEmptyChildren [
	
	| theChildren |
	theChildren := self newChildrenCollection.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testEmptyChildrenExplicitCreation [
	
	| theChildren |
	theChildren := BlChildrenLinkedList new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testFirst [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren first userData at: #index) equals: 1.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testIfEmpty [
	
	| theChildren |
	theChildren := self fill: 0.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: #empty.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testIfEmptyNot [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: theChildren.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testIndexOf [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: (theChildren at: 1)) equals: 1.
	self assert: (theChildren indexOf: (theChildren at: 5)) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testIndexOfUnknown [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: BlElement new) equals: 0.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testIsEmpty [
	
	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren isEmpty.
	theChildren := self fill: 5.
	self deny: theChildren isEmpty.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testIsNotEmpty [
	
	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren isNotEmpty not.
	theChildren := self fill: 5.
	self assert: theChildren isNotEmpty.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testLast [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren last userData at: #index) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testRemove [
	
	| theChildren indices |
	theChildren := self fill: 5.
	theChildren remove: (theChildren at: 3).
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 4.
	self assert: indices equals: #(1 2 4 5).
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testRemoveAll [
	
	| theChildren indices |
	theChildren := self fill: 5.
	theChildren
		removeAll:
			{(theChildren at: 5).
			(theChildren at: 3).
			(theChildren at: 1)}.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #(2 4).
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testRemoveAt [
	
	| theChildren indices |
	theChildren := self fill: 5.
	theChildren removeAt: 5.
	theChildren removeAt: 3.
	theChildren removeAt: 1.
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #(2 4).
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testSecond [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren second userData at: #index) equals: 2.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testSize [
	
	| theChildren |
	theChildren := self fill: 5.
	self assert: theChildren size equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenLinkedListTest >> testSizeEmpty [
	
	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren size equals: 0.
	^ theChildren
]
