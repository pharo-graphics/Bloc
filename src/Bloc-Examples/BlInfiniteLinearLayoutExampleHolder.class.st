Class {
	#name : #BlInfiniteLinearLayoutExampleHolder,
	#superclass : #BlInfiniteHolder,
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteLinearLayoutExampleHolder >> color: aColor [
	itemElement background: aColor
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleHolder >> constraintsDo: aBlock [
	itemElement constraintsDo: aBlock
]

{ #category : #initialization }
BlInfiniteLinearLayoutExampleHolder >> initialize [
	super initialize.
	
	itemElement := BlElement new.
	itemElement size: 0@0
]
