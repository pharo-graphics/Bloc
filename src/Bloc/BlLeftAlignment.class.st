"
I represent left alignment.
See BlLayoutAlignment for more info.

"
Class {
	#name : #BlLeftAlignment,
	#superclass : #BlHorizontalAlignment,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlLeftAlignment class >> initialize [

	self initializeSingletons
]

{ #category : #factory }
BlLeftAlignment class >> leftToRight [
	^ self left
]

{ #category : #factory }
BlLeftAlignment class >> rightToLeft [
	^ self right
]

{ #category : #factory }
BlLeftAlignment >> inverted [
	^ BlElementAlignment vertical start
]

{ #category : #factory }
BlLeftAlignment >> swap [
	^ BlElementAlignment right
]

{ #category : #translation }
BlLeftAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>

	^ (aContainerBounds left - aBounds left) @ 0
]
