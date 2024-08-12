"
I sort a collection of children by perimeter in ascending order.

"
Class {
	#name : #BlChildrenSortedByPerimeter,
	#superclass : #BlChildrenSubset,
	#category : #'Bloc-Basic-Children'
}

{ #category : #accessing }
BlChildrenSortedByPerimeter >> name [

	^ 'Sorted by permeter'
]

{ #category : #'children - subsets' }
BlChildrenSortedByPerimeter >> sortedByPerimeter [

	^ self
]

{ #category : #initialization }
BlChildrenSortedByPerimeter >> subsetFrom: aBlChildren [
	"Perform the sort when the instance is created."

	^ aBlChildren asArray sorted: [ :a :b |
		  a measuredBounds perimeter >= b measuredBounds perimeter ]
]
