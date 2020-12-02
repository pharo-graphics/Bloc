Class {
	#name : #BlElementSelectedStateWish,
	#superclass : #BlElementStateWish,
	#instVars : [
		'selected'
	],
	#category : #'Bloc-Basic-State'
}

{ #category : #accessing }
BlElementSelectedStateWish >> selected [
	^ selected
]

{ #category : #accessing }
BlElementSelectedStateWish >> selected: anObject [
	selected := anObject
]
