Class {
	#name : #BlInfiniteExampleGalleryElementHolder,
	#superclass : #BlInfiniteElementHolder,
	#instVars : [
		'image'
	],
	#category : 'Bloc-Infinite-Examples-Core - Gallery'
}

{ #category : #accessing }
BlInfiniteExampleGalleryElementHolder >> image [
	^ image
]

{ #category : #accessing }
BlInfiniteExampleGalleryElementHolder >> image: anImage [

	image = anImage
		ifTrue: [ ^ self ].

	image := anImage.
	itemElement image: anImage
]

{ #category : #initialization }
BlInfiniteExampleGalleryElementHolder >> initialize [
	super initialize.

	itemElement := BlInfiniteExampleGalleryImageElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent.
			c margin: (BlInsets top: 0 right: 0 bottom: 4 left: 0) ];
		yourself
]
