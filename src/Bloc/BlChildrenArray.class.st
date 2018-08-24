"
I store children in an immutable array.


"
Class {
	#name : #BlChildrenArray,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'array'
	],
	#category : 'Bloc-Basic-Children'
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

	"if user passed array and our current array is empty, we could
	just replace it directly - no need to waste time making a copy of array"
	array := (array isEmpty and: [ aSequenceableCollection isArray ])
		ifTrue: [ aSequenceableCollection ]
		ifFalse: [ array, aSequenceableCollection ]
]

{ #category : #converting }
BlChildrenArray >> asArray [
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
