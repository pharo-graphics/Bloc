"
I reverse an underlying collection children.

Example:
[[[
| element |
element := BlElement new.
element children reversed
]]]
"
Class {
	#name : #BlChildrenReversed,
	#superclass : #BlChildrenSubset,
	#category : 'Bloc-Basic-Children'
}

{ #category : #'instance creation' }
BlChildrenReversed class >> on: aBlChildren [
	^ self new initializeFrom: aBlChildren
]

{ #category : #'children - accessing' }
BlChildrenReversed >> at: anIndex [
	<return: #BlElement>

	^ super at: (self size - anIndex + 1)
]

{ #category : #'children - enumerating' }
BlChildrenReversed >> do: aBlock [
	subsetArray reverseDo: aBlock
]

{ #category : #accessing }
BlChildrenReversed >> name [
	^ 'Reversed'
]

{ #category : #'children - subsets' }
BlChildrenReversed >> reversed [
	^ BlChildrenArray from: subsetArray
]

{ #category : #initialization }
BlChildrenReversed >> subsetFrom: aBlChildren [
	^ aBlChildren asArray
]
