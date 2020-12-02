Class {
	#name : #BlElementExpandedStateWish,
	#superclass : #BlElementStateWish,
	#instVars : [
		'expanded'
	],
	#category : #'Bloc-Basic-State'
}

{ #category : #accessing }
BlElementExpandedStateWish >> expanded [
	^ expanded
]

{ #category : #accessing }
BlElementExpandedStateWish >> expanded: anObject [
	expanded := anObject
]
