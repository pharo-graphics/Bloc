Class {
	#name : #BlInfiniteChildBoundsBasedFinder,
	#superclass : #BlChildBoundsBasedFinder,
	#instVars : [
		'layout'
	],
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> childAt: anIndex [
	<return: #BlElement>
	
	^ layout childAt: anIndex
]

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> layout [
	^ layout
]

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> layout: anObject [
	layout := anObject
]
