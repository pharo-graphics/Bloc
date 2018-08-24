Class {
	#name : #BlChildrenArrayTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests-Basic-Support'
}

{ #category : #'instance creation' }
BlChildrenArrayTest >> fill: aNumber [
	| childrenArray |
	
	childrenArray := BlChildrenArray new.
	
	1 to: aNumber do: [ :anIndex |
		| anElement |
		anElement := BlElement new.
		anElement userData at: #index put: anIndex.
		childrenArray add: anElement ].
	
	^ childrenArray
]

{ #category : #tests }
BlChildrenArrayTest >> testAdd [
	| childrenArray indices element |
	
	childrenArray := self fill: 0.

	element := BlElement new.
	element userData at: #index put: 1.
	childrenArray add: element.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 1.
	self assert: indices equals: #(1).
	
	element := BlElement new.
	element userData at: #index put: 2.
	childrenArray add: element.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(1 2)
]

{ #category : #tests }
BlChildrenArrayTest >> testAddAt [
	| childrenArray indices element |
	
	childrenArray := self fill: 0.

	element := BlElement new.
	element userData at: #index put: 1.
	childrenArray add: element at: 1.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 1.
	self assert: indices equals: #(1).
	
	element := BlElement new.
	element userData at: #index put: 2.
	childrenArray add: element at: 1.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(2 1).
	
	element := BlElement new.
	element userData at: #index put: 3.
	childrenArray add: element at: 2.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 3.
	self assert: indices equals: #(2 3 1).
	
	element := BlElement new.
	element userData at: #index put: 4.
	childrenArray add: element at: 4.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 4.
	self assert: indices equals: #(2 3 1 4)
]

{ #category : #tests }
BlChildrenArrayTest >> testAsArray [
	| childrenArray all indices |
	
	childrenArray := self fill: 5.
	all := childrenArray asArray.
	indices := all collect: [ :each | each userData at: #index ].
	self assert: indices equals: #(1 2 3 4 5).
	
	childrenArray := self fill: 0.
	all := childrenArray asArray.
	indices := all collect: [ :each | each userData at: #index ].
	self assert: indices equals: #()
]

{ #category : #tests }
BlChildrenArrayTest >> testAt [
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: ((childrenArray at: 1) userData at: #index) equals: 1.
	self assert: ((childrenArray at: 3) userData at: #index) equals: 3.
	self assert: ((childrenArray at: 5) userData at: #index) equals: 5.
]

{ #category : #tests }
BlChildrenArrayTest >> testAtIfAbsent [
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: ((childrenArray at: 1) userData at: #index) equals: 1.
	self assert: ((childrenArray at: 3) userData at: #index) equals: 3.
	self assert: ((childrenArray at: 5) userData at: #index) equals: 5.
	
	
	self assert: ((childrenArray at: 0 ifAbsent: [
		| anElement |
		anElement := BlElement new.
		anElement userData at: #index put: 0.
		anElement ]) userData at: #index)
	equals: 0.
	
	self assert: ((childrenArray at: 10 ifAbsent: [
		| anElement |
		anElement := BlElement new.
		anElement userData at: #index put: 10.
		anElement ]) userData at: #index)
	equals: 10.
]

{ #category : #tests }
BlChildrenArrayTest >> testFirst [
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: (childrenArray first userData at: #index) equals: 1.
]

{ #category : #tests }
BlChildrenArrayTest >> testIfEmpty [
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray ifEmpty: [ #empty ]) equals: childrenArray.
	
	childrenArray := self fill: 0.
	self assert: (childrenArray ifEmpty: [ #empty ]) equals: #empty
]

{ #category : #tests }
BlChildrenArrayTest >> testIndexOf [
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray indexOf: (childrenArray at: 1)) equals: 1.
	self assert: (childrenArray indexOf: (childrenArray at: 5)) equals: 5.
	self assert: (childrenArray indexOf: (BlElement new)) equals: 0.
]

{ #category : #tests }
BlChildrenArrayTest >> testIsEmpty [
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: childrenArray isEmpty not.
	
	childrenArray := self fill: 0.
	self assert: childrenArray isEmpty.
]

{ #category : #tests }
BlChildrenArrayTest >> testLast [
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: (childrenArray last userData at: #index) equals: 5
]

{ #category : #tests }
BlChildrenArrayTest >> testRemove [
	| childrenArray indices |
	
	childrenArray := self fill: 5.
	childrenArray remove: (childrenArray at: 3).
	indices := childrenArray collect: [ :each | each userData at: #index ].
	
	self assert: (childrenArray size) equals: 4.
	self assert: indices equals: #(1 2 4 5)
]

{ #category : #tests }
BlChildrenArrayTest >> testRemoveAll [
	| childrenArray indices |
	
	childrenArray := self fill: 5.
	childrenArray removeAll: {
		childrenArray at: 5.
		childrenArray at: 3.
		childrenArray at: 1.
	}.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(2 4)
]

{ #category : #tests }
BlChildrenArrayTest >> testRemoveAt [
	| childrenArray indices |
	
	childrenArray := self fill: 5.
	childrenArray removeAt: 5.
	childrenArray removeAt: 3.
	childrenArray removeAt: 1.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(2 4)
]

{ #category : #tests }
BlChildrenArrayTest >> testSecond [
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray second userData at: #index) equals: 2
]

{ #category : #tests }
BlChildrenArrayTest >> testSize [
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray size) equals: 5.
	
	childrenArray := self fill: 0.
	self assert: (childrenArray size) equals: 0
]
