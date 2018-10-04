Class {
	#name : #BlBackgroundExactResizer,
	#superclass : #BlBackgroundResizer,
	#instVars : [
		'extent'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #resizing }
BlBackgroundExactResizer >> adapt: aBackground to: anElement [
	aBackground matchExtent: self extent
]

{ #category : #accessing }
BlBackgroundExactResizer >> extent [
	^ extent
]

{ #category : #accessing }
BlBackgroundExactResizer >> extent: anObject [
	extent := anObject
]
