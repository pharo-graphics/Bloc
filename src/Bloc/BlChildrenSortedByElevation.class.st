"
I sort a collection of children by elevation in ascending order.

{{gtExample:BlChildrenSubsetExamples>>#sortedByElevationFromElement}}


"
Class {
	#name : #BlChildrenSortedByElevation,
	#superclass : #BlChildrenSubset,
	#category : #'Bloc-Basic-Children'
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
	"Perform the sort when the instance is created."
	^ aBlChildren asArray sorted: [ :a :b | a elevation elevation <= b elevation elevation  ]
]
