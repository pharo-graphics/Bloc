Class {
	#name : 'BlInfiniteHorizontalChildBoundsBasedFinder',
	#superclass : 'BlInfiniteChildBoundsBasedFinder',
	#category : 'Bloc-Infinite-Layout',
	#package : 'Bloc-Infinite',
	#tag : 'Layout'
}

{ #category : 'accessing' }
BlInfiniteHorizontalChildBoundsBasedFinder >> childEndOf: anElement [
	
	^ (layout decoratedRight: anElement) + anElement margin right
]

{ #category : 'accessing' }
BlInfiniteHorizontalChildBoundsBasedFinder >> childStartOf: anElement [
	
	^ (layout decoratedLeft: anElement) - anElement margin left
]

{ #category : 'accessing' }
BlInfiniteHorizontalChildBoundsBasedFinder >> parentEnd [
	
	^ layout width - layout paddingRight
]

{ #category : 'accessing' }
BlInfiniteHorizontalChildBoundsBasedFinder >> parentStart [
	
	^ layout paddingLeft
]
