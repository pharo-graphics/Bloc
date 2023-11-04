Class {
	#name : 'BlChildrenSortedByElevationReversed',
	#superclass : 'BlChildrenSubset',
	#package : 'Bloc',
	#tag : 'Basic-Children'
}

{ #category : 'children - subsets' }
BlChildrenSortedByElevationReversed >> sortedByElevationReversed [
	^ self
]

{ #category : 'initialization' }
BlChildrenSortedByElevationReversed >> subsetFrom: aBlChildren [
	"Perform the sort when the instance is created."
	^ aBlChildren asArray sorted: [ :a :b | 
		(a elevation relatedTo: 0) > (b elevation relatedTo: 0) ]
]
