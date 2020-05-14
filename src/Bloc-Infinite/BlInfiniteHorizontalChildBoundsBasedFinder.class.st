Class {
	#name : #BlInfiniteHorizontalChildBoundsBasedFinder,
	#superclass : #BlInfiniteChildBoundsBasedFinder,
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #accessing }
BlInfiniteHorizontalChildBoundsBasedFinder >> childEndOf: anElement [
	<return: #Number>
	
	^ (layout decoratedRight: anElement) + anElement margin right
]

{ #category : #accessing }
BlInfiniteHorizontalChildBoundsBasedFinder >> childStartOf: anElement [
	<return: #Number>
	
	^ (layout decoratedLeft: anElement) - anElement margin left
]

{ #category : #accessing }
BlInfiniteHorizontalChildBoundsBasedFinder >> parentEnd [
	<return: #Number>
	
	^ layout width - layout paddingRight
]

{ #category : #accessing }
BlInfiniteHorizontalChildBoundsBasedFinder >> parentStart [
	<return: #Number>
	
	^ layout paddingLeft
]
