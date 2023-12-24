Class {
	#name : #BlInfiniteVerticalChildBoundsBasedFinder,
	#superclass : #BlInfiniteChildBoundsBasedFinder,
	#category : 'Bloc-Infinite-Layout'
}

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> childEndOf: anElement [
	
	^ (layout decoratedBottom: anElement) + anElement margin bottom
]

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> childStartOf: anElement [
	
	^ (layout decoratedTop: anElement) - anElement margin top
]

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> parentEnd [
	
	^ layout height - layout paddingBottom
]

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> parentStart [
	
	^ layout paddingTop
]
