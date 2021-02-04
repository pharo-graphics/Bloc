"
I am a holder that uses an immutable array to store children of bloc elements.

Every time a child is added or removed I create a new internal array to store children. 
I optimize the method ${method:BlChildrenArray>>#asArray}$ to directly return the internal array instead of creating a new one. In combination with other iterators that use this method (like ${class:BlChildrenReversed}$) it can reduce the number of arrays created during layout operations, expecially for graph layouts.

!!Examples
Examples are provided by the class ${class:BlChildrenArrayExamples}$
"
Class {
	#name : #BlChildrenArray,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'array'
	],
	#category : #'Bloc-Basic-Children'
}

{ #category : #'instance creation' }
BlChildrenArray class >> from: anArrayOfChildren [
	^ self new initializeFrom: anArrayOfChildren
]

{ #category : #'children - adding' }
BlChildrenArray >> add: aChild at: anIndex [
	"Adds aChild at a given index moving existing children to the right"

	array := array copyReplaceFrom: anIndex to: anIndex - 1 with: { aChild }
]

{ #category : #'children - adding' }
BlChildrenArray >> addAll: aSequenceableCollection [
	"Add all the elements from the given collection to the children array.
	If the user passed an array and our current array is empty, we just replace 
	it directly - no need to waste time making a copy of array. Callers should 
	no longer modify the given array."
	array := (array isEmpty and: [ aSequenceableCollection isArray ])
		ifTrue: [ aSequenceableCollection ]
		ifFalse: [ array, aSequenceableCollection ]
]

{ #category : #converting }
BlChildrenArray >> asArray [
	"Directly return the internal array used to store children.
	This avoids creating an extra array, as this operation can be called many times.
	Callers should create a copy of the array if they need to modify it,
	as adding or removing elements will create a new array used internally."
	^ array
]

{ #category : #'children - accessing' }
BlChildrenArray >> at: anIndex [
	"Return an element at a given index"
	<return: #BlElement>

	^ array at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenArray >> do: aBlock [
	array do: aBlock
]

{ #category : #initialization }
BlChildrenArray >> initialize [
	super initialize.
	
	array := #()
]

{ #category : #initialization }
BlChildrenArray >> initializeFrom: anArrayOfChildren [
	array := anArrayOfChildren asArray
]

{ #category : #accessing }
BlChildrenArray >> name [
	^ 'Children array'
]

{ #category : #'children - removing' }
BlChildrenArray >> removeAll: aCollectionOfBlElement [
	array := array copyWithoutAll: aCollectionOfBlElement
]

{ #category : #'children - removing' }
BlChildrenArray >> removeAt: anIndex [
	array := array copyReplaceFrom: anIndex to: anIndex with: #()
]

{ #category : #'children - accessing' }
BlChildrenArray >> size [
	<return: #Number>

	^ array size
]

{ #category : #'children - swapping' }
BlChildrenArray >> swapAt: aChildIndex with: anotherChildIndex [
	aChildIndex = anotherChildIndex
		ifTrue: [ ^ self ].
		
	self
		assert: [ aChildIndex between: 1 and: self size ]
		description: [ 'Child index must be within bounds' ].
		
	self
		assert: [ anotherChildIndex between: 1 and: self size ]
		description: [ 'Child index must be within bounds' ].
		
	array swap: aChildIndex with: anotherChildIndex
]
