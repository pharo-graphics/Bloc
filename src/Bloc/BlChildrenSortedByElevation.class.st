"
A collection of children sorted by elevation in ascending order

Example:
[[[
| element |
element := BlElement new.
element children sortedByElevation
]]]
"
Class {
	#name : #BlChildrenSortedByElevation,
	#superclass : #BlChildrenSubset,
	#category : 'Bloc-Basic-Children'
}

{ #category : #accessing }
BlChildrenSortedByElevation >> name [
	^ 'Sorted by elevation'
]

{ #category : #'children - subsets' }
BlChildrenSortedByElevation >> sortedByElevation [
	^ self
]

{ #category : #initialization }
BlChildrenSortedByElevation >> subsetFrom: aBlChildren [
	^ aBlChildren asArray sorted: [ :a :b | (a elevation relatedTo: 0) <= (b elevation relatedTo: 0) ]
]
