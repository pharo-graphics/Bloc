Class {
	#name : #BlInfiniteItemInfoHolder,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent',
		'flags'
	],
	#category : 'Bloc-Infinite-Animator'
}

{ #category : #initialization }
BlInfiniteItemInfoHolder >> initialize [
	super initialize.
	
	position := 0@0.
	extent := 0@0.
	flags := Dictionary new
]

{ #category : #initialization }
BlInfiniteItemInfoHolder >> initializeWith: anElementHolder [
]
