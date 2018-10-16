"
I define examples common to all types of ${class:BlChildrenCollection}$.

Classes that are using me should define the concrete type of ${class:BlChildrenCollection}$ that is being tested using the method ${method:TBlChildrenExample>>#newChildrenCollection}$.
"
Trait {
	#name : #TBlChildrenExample,
	#category : #'Bloc-Examples-Children'
}

{ #category : #'examples - add' }
TBlChildrenExample >> add [
	<gtExample>
	| theChildren indices |
	
	theChildren := self emptyChildren.

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

{ #category : #'examples - add' }
TBlChildrenExample >> addAt [
	<gtExample>
	| theChildren indices |
	
	theChildren := self emptyChildren.

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

{ #category : #'examples - children' }
TBlChildrenExample >> asArray [
	<gtExample>
	| theChildren indices |
	
	theChildren := self fill: 5.

	indices := theChildren asArray collect: [ :each | each userData at: #index ].
	self assert: indices equals: #(1 2 3 4 5).
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> asArrayEmpty [
	<gtExample>
	| theChildren indices |
	
	theChildren := self emptyChildren.

	indices := theChildren asArray collect: [ :each | each userData at: #index ].
	self assert: indices equals: #().
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> at [
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

{ #category : #'examples - children' }
TBlChildrenExample >> atIfAbsent [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: ((theChildren at: 1) userData at: #index) equals: 1.
	self assert: ((theChildren at: 3) userData at: #index) equals: 3.
	self assert: ((theChildren at: 5) userData at: #index) equals: 5.
	
	self 
		assert: ((theChildren at: 0 ifAbsent: [
			| anElement |
			anElement := BlElement new.
			anElement userData at: #index put: 0.
			anElement ]) userData at: #index)
		equals: 0.
	
	self 
		assert: ((theChildren at: 10 ifAbsent: [
			| anElement |
			anElement := BlElement new.
			anElement userData at: #index put: 10.
			anElement ]) userData at: #index)
		equals: 10.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> emptyChildren [
	<gtExample>
	| theChildren |

	theChildren := self newChildrenCollection.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #private }
TBlChildrenExample >> fill: aNumber [
	| childrenArray |
	
	childrenArray := self emptyChildren.	
	1 to: aNumber do: [ :anIndex |
		childrenArray add: (self newChildAt: anIndex) ].

	^ childrenArray
]

{ #category : #'examples - children' }
TBlChildrenExample >> first [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren first userData at: #index) equals: 1.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> ifEmpty [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 0.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: #empty.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> ifEmptyNot [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren ifEmpty: [ #empty ]) equals: theChildren.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> indexOf [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: (theChildren at: 1)) equals: 1.
	self assert: (theChildren indexOf: (theChildren at: 5)) equals: 5.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> indexOfUnknown [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren indexOf: (BlElement new)) equals: 0.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> isEmpty [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 0.
	self assert: theChildren isEmpty.
	
	theChildren := self fill: 5.
	self assert: theChildren isEmpty not.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> isNotEmpty [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 0.
	self assert: theChildren isNotEmpty not.
	
	theChildren := self fill: 5.
	self assert: theChildren isNotEmpty.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> last [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren last userData at: #index) equals: 5.
	
	^ theChildren
]

{ #category : #private }
TBlChildrenExample >> newChildAt: anIndex [
	| anElement |
	anElement := BlElement new.
	anElement userData at: #index put: anIndex.
	^ anElement
]

{ #category : #'instance creation' }
TBlChildrenExample >> newChildrenCollection [
	"Instantiate the type of children collection under test"
	^ self explicitRequirement
]

{ #category : #'examples - remove' }
TBlChildrenExample >> remove [
	<gtExample>
	| theChildren indices |
	
	theChildren := self fill: 5.
	theChildren remove: (theChildren at: 3).
	
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: (theChildren size) equals: 4.
	self assert: indices equals: #(1 2 4 5).
	
	^ theChildren
]

{ #category : #'examples - remove' }
TBlChildrenExample >> removeAll [
	<gtExample>
	| theChildren indices |
	
	theChildren := self fill: 5.
	theChildren removeAll: {
		theChildren at: 5.
		theChildren at: 3.
		theChildren at: 1.
	}.
	
	indices := theChildren collect: [ :each | each userData at: #index ].
	self assert: theChildren size equals: 2.
	self assert: indices equals: #(2 4).
	
	^ theChildren
]

{ #category : #'examples - remove' }
TBlChildrenExample >> removeAt [
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

{ #category : #'examples - children' }
TBlChildrenExample >> second [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren second userData at: #index) equals: 2.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> size [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 5.
	self assert: (theChildren size) equals: 5.
	
	^ theChildren
]

{ #category : #'examples - children' }
TBlChildrenExample >> sizeEmpty [
	<gtExample>
	| theChildren |
	
	theChildren := self fill: 0.
	self assert: (theChildren size) equals: 0.
	
	^ theChildren
]
