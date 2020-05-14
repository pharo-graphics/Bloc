Class {
	#name : #BlInfiniteVerticalChildBoundsBasedFinder,
	#superclass : #BlInfiniteChildBoundsBasedFinder,
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> childEndOf: anElement [
	<return: #Number>
	
	^ (layout decoratedBottom: anElement) + anElement margin bottom
]

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> childStartOf: anElement [
	<return: #Number>
	
	^ (layout decoratedTop: anElement) - anElement margin top
]

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> parentEnd [
	<return: #Number>
	
	^ layout height - layout paddingBottom
]

{ #category : #accessing }
BlInfiniteVerticalChildBoundsBasedFinder >> parentStart [
	<return: #Number>
	
	^ layout paddingTop
]
