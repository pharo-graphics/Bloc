"
I am an abstract root class designed for accessing and iterating over the children of a `BlElement`. 

I define a data structure independent API for iterating and accessing bloc elements. I assume an index-based way of accessing bloc elements. Subclasses can filter elements or have different orders to iterate over them.

## API

Subclasses need to overide the following abstract methods to provide access to the actual bloc elements:
- `BlChildren>>#at:`
- `BlChildren>>#do:`
- `BlChildren>>#size`

Additionally, I provide an API for selecting only subsets of children, or iterating over them in a differen order, like:
- `BlChildren>>#accountedByLayout`
- `BlChildren>>#ignoredByLayout`
- `BlChildren>>#reversed`
- `BlChildren>>#sortedByElevation`

Important API methods: 
- `BlChildren>>#asArray`: returns an array with all the elements.

"
Class {
	#name : #BlChildren,
	#superclass : #Collection,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Children'
}

{ #category : #'children - subsets' }
BlChildren >> accountedByLayout [
	<return: #BlChildren>
	
	^ BlChildrenAccountedByLayout on: self
]

{ #category : #'children - enumerating' }
BlChildren >> anySatisfy: aBlock [
	"Evaluate aBlock with the elements of the receiver.
	If aBlock returns true for any element return true.
	Otherwise return false."

	self do: [:each | (aBlock value: each) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'children - converting' }
BlChildren >> asArray [
	<return: #Array of: #BlElement>
	"Create an array containing all the children.
	Users should not assume a new array is created all the time, 
	and should use the array only for iteration and not modifications."
	^ Array 
		new: self size 
		streamContents: [ :aStream | 
			self do: [ :anElement | aStream nextPut: anElement ] ]
]

{ #category : #'children - accessing' }
BlChildren >> at: anIndex [
	"Return an element at a given index without taking zIndex into account"
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #'children - accessing' }
BlChildren >> at: anIndex ifAbsent: exceptionBlock [ 
	"Answer the element at my position index. If I do not contain an element 
	at index, answer the result of evaluating the argument, exceptionBlock."

	(anIndex between: 1 and: self size)
		ifTrue: [ ^ self at: anIndex ].
	^ exceptionBlock value
]

{ #category : #'children - enumerating' }
BlChildren >> collect: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Collect the resulting values into a collection like the receiver. Answer  
	the new collection."
	<return: #Array>

	^ Array streamContents: [ :aStream |
		self do: [ :anElement | aStream nextPut: (aBlock value: anElement) ] ]
]

{ #category : #'children - enumerating' }
BlChildren >> detect: aBlock ifFound: foundBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock. 
	If no element matches the criteria then do nothing.
	Always returns self to avoid misuse and a potential isNil check on the sender."
	<return: #Object or: nil>

	^ self
		detect: aBlock
		ifFound: foundBlock
		ifNone: [ "Do nothing on purpose" ]
]

{ #category : #'children - enumerating' }
BlChildren >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #Object or: nil>

	self do: [ :each | 
		(aBlock value: each)
			ifTrue: [ ^ foundBlock cull: each ] ].
	^ exceptionBlock value
]

{ #category : #'children - enumerating' }
BlChildren >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Answer the first element for which aBlock evaluates to true. If none  
	evaluate to true, then evaluate the argument, exceptionBlock."
	<return: #Object or: nil>

	^ self
		detect: aBlock
		ifFound: [ :element | element ]
		ifNone: exceptionBlock
]

{ #category : #'children - enumerating' }
BlChildren >> do: aBlock [
	self subclassResponsibility
]

{ #category : #caching }
BlChildren >> elevationChanged [
]

{ #category : #private }
BlChildren >> errorNotFound: anObject [
	"Raise a NotFound exception."

	NotFound signalFor: anObject
]

{ #category : #'children - accessing' }
BlChildren >> fifth [
	<return: #BlElement>

	^ self at: 5
]

{ #category : #'children - accessing' }
BlChildren >> first [
	<return: #BlElement>

	^ self at: 1
]

{ #category : #'children - enumerating' }
BlChildren >> flatCollect: aBlock [
	"Evaluate aBlock for each of the receiver's elements and answer the
	list of all resulting values flatten one level. Assumes that aBlock returns some kind
	of collection for each element. Equivalent to the lisp's mapcan"
	<return: #Array>

	^ Array streamContents: [ :aStream |
		self do: [ :anElement | aStream nextPutAll: (aBlock value: anElement) ] ]
]

{ #category : #'children - accessing' }
BlChildren >> fourth [
	<return: #BlElement>

	^ self at: 4
]

{ #category : #testing }
BlChildren >> hasSuperset [
	"I indicate whether or not the intent is to iterate over the complete set of children of an element."
	
	 ^ false
]

{ #category : #'children - testing' }
BlChildren >> ifEmpty: aBlock [
	"Evaluate the given block, answering its value if the receiver is empty, otherwise answer the receiver."
	
	"Note that the fact that this method returns its receiver in case the receiver is not empty allows one to write expressions like the following ones: self classifyMethodAs: (myProtocol ifEmpty: ['As yet unclassified'])"

	^ self isEmpty 
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #'children - subsets' }
BlChildren >> ignoredByLayout [
	<return: #BlChildren>
	
	^ BlChildrenIgnoredByLayout on: self
]

{ #category : #'children - accessing' }
BlChildren >> indexOf: anElement [
	"Answer the index of the first occurrence of anElement within the  
	receiver. If the receiver does not contain anElement, answer 0."
	<return: #Number>

	^ self indexOf: anElement ifAbsent: 0
]

{ #category : #'children - accessing' }
BlChildren >> indexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurence of anElement within the  
	receiver. If the receiver does not contain anElement, answer the 
	result of evaluating the argument, exceptionBlock."

	self withIndexDo: [ :eachElement :anIndex |
		(eachElement = anElement)
			ifTrue: [ ^ anIndex ] ].
	^ exceptionBlock value
]

{ #category : #'children - enumerating' }
BlChildren >> inject: thisValue into: binaryBlock [
	"Accumulate a running value associated with evaluating the argument, 
	binaryBlock, with the current value of the argument, thisValue, and the 
	receiver as block arguments. For instance, to sum the numeric elements 
	of a collection, aCollection inject: 0 into: [:subTotal :next | subTotal + 
	next]."
	| nextValue |

	nextValue := thisValue.
	self do: [ :anElement | nextValue := binaryBlock value: nextValue value: anElement ].
	^ nextValue
]

{ #category : #testing }
BlChildren >> isCollection [
	^ true
]

{ #category : #'children - testing' }
BlChildren >> isEmpty [

	^ self size isZero
]

{ #category : #'children - testing' }
BlChildren >> isNotEmpty [
	<return: #Boolean>

	^ self size isZero not
]

{ #category : #'children - accessing' }
BlChildren >> last [
	<return: #BlElement>

	^ self at: self size
]

{ #category : #accessing }
BlChildren >> name [
	^ 'Children'
]

{ #category : #printing }
BlChildren >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPut: Character space;
		nextPut: $(;
		nextPutAll: self size asString;
		nextPut: $)
]

{ #category : #'children - enumerating' }
BlChildren >> reject: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver only those elements for 
	which aBlock evaluates to false. Answer the new collection."
	<return: #Array of: #BlElement>
	
	^ self select: [ :anElement | (aBlock value: anElement) == false ]
]

{ #category : #'children - enumerating' }
BlChildren >> reverseDo: aBlock [
	self reversed do: aBlock
]

{ #category : #'children - subsets' }
BlChildren >> reversed [
	<return: #BlChildren>
	
	^ BlChildrenReversed on: self
]

{ #category : #'children - accessing' }
BlChildren >> second [
	<return: #BlElement>

	^ self at: 2
]

{ #category : #'children - enumerating' }
BlChildren >> select: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #Array of: #BlElement>
	
	^ Array streamContents: [ :aStream |
			self do: [ :anElement |
				(aBlock value: anElement)
					ifTrue: [ aStream nextPut: anElement ] ] ]
]

{ #category : #'children - enumerating' }
BlChildren >> select: selectBlock thenDo: doBlock [
	"Utility method to improve readability.
	Do not create the intermediate collection."
	
	self do: [ :anElement |
		(selectBlock value: anElement)
			ifTrue: [ doBlock value: anElement ] ]
]

{ #category : #'children - accessing' }
BlChildren >> size [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - subsets' }
BlChildren >> sortedByElevation [
	<return: #BlChildren>

	^ BlChildrenSortedByElevation on: self
]

{ #category : #'children - subsets' }
BlChildren >> sortedByPerimeter [

	^ BlChildrenSortedByPerimeter on: self
]

{ #category : #private }
BlChildren >> species [
	^ Array
]

{ #category : #'children - accessing' }
BlChildren >> third [
	<return: #BlElement>

	^ self at: 3
]

{ #category : #'children - enumerating' }
BlChildren >> withIndexDo: elementAndIndexBlock [ 
	"Just like with:do: except that the iteration index supplies the second argument to the block."
	| anIndex |
	
	anIndex := 0.
	self do: [ :anElement |
		anIndex := anIndex + 1.
		elementAndIndexBlock
			value: anElement
			value: anIndex ]
]
