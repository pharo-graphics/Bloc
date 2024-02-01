Class {
	#name : #BlChildrenSortedByElevationReversed,
	#superclass : #BlChildrenSubset,
	#category : #'Bloc-Basic-Children'
}

{ #category : #'children - subsets' }
BlChildrenSortedByElevationReversed >> sortedByElevationReversed [
	^ self
]

{ #category : #initialization }
BlChildrenSortedByElevationReversed >> subsetFrom: aBlChildren [
	"Perform the sort when the instance is created."
	^ aBlChildren asArray sorted: [ :a :b | 
		(a elevation relatedTo: 0) > (b elevation relatedTo: 0) ]
]
