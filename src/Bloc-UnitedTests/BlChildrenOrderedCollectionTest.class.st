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
	1 to: aNumber do: [ :anIndex | childrenArray add: (self newChildAt: anIndex) ].
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

{ #category : #metadata }
BlChildrenOrderedCollectionTest >> originClassName [
	"This test was generated from..."
	^ 'BlChildrenOrderedCollectionExamples'
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testAdd [
	<gtExample>
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
BlChildrenOrderedCollectionTest >> testAddAt [
	<gtExample>
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
BlChildrenOrderedCollectionTest >> testAsArray [
	<gtExample>
	| theChildren indices |
	theChildren := self fill: 5.
	indices := theChildren asArray
		collect: [ :each | each userData at: #index ].
	self assert: indices equals: #(1 2 3 4 5).
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testAsArrayEmpty [
	<gtExample>
	| theChildren indices |
	theChildren := self testEmptyChildren.
	indices := theChildren asArray
		collect: [ :each | each userData at: #index ].
	self assert: indices equals: #().
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testAt [
	<gtExample>
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
BlChildrenOrderedCollectionTest >> testAtIfAbsent [
	<gtExample>
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
BlChildrenOrderedCollectionTest >> testEmptyChildren [
	<gtExample>
	| theChildren |
	theChildren := self newChildrenCollection.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testEmptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |
	theChildren := BlChildrenOrderedCollection new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testFirst [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren first userData at: #index) equals: 1.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIfEmpty [
	<gtExample>
	| theChildren |
	theChildren := self fill: 0.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: #empty.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIfEmptyNot [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: theChildren.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIndexOf [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: (theChildren at: 1)) equals: 1.
	self assert: (theChildren indexOf: (theChildren at: 5)) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIndexOfUnknown [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: BlElement new) equals: 0.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIsEmpty [
	<gtExample>
	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren isEmpty.
	theChildren := self fill: 5.
	self assert: theChildren isEmpty not.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testIsNotEmpty [
	<gtExample>
	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren isNotEmpty not.
	theChildren := self fill: 5.
	self assert: theChildren isNotEmpty.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testLast [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren last userData at: #index) equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testRemove [
	<gtExample>
	| theChildren indices |
	theChildren := self fill: 5.
	theChildren remove: (theChildren at: 3).
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 4.
	self assert: indices equals: #(1 2 4 5).
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testRemoveAll [
	<gtExample>
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
BlChildrenOrderedCollectionTest >> testRemoveAt [
	<gtExample>
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
BlChildrenOrderedCollectionTest >> testSecond [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: (theChildren second userData at: #index) equals: 2.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testSize [
	<gtExample>
	| theChildren |
	theChildren := self fill: 5.
	self assert: theChildren size equals: 5.
	^ theChildren
]

{ #category : #tests }
BlChildrenOrderedCollectionTest >> testSizeEmpty [
	<gtExample>
	| theChildren |
	theChildren := self fill: 0.
	self assert: theChildren size equals: 0.
	^ theChildren
]
