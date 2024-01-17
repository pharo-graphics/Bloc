"
I represent left alignment.
See BlLayoutAlignment for more info.

"
Class {
	#name : 'BlLeftAlignment',
	#superclass : 'Object',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlLeftAlignment class >> leftToRight [
	^ self left
]

{ #category : 'factory' }
BlLeftAlignment class >> rightToLeft [
	^ self right
]

{ #category : 'factory' }
BlLeftAlignment >> inverted [
	^ BlElementAlignment vertical start
]

{ #category : 'factory' }
BlLeftAlignment >> swap [
	^ BlElementAlignment right
]

{ #category : 'translation' }
BlLeftAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>

	^ (aContainerBounds left - aBounds left) @ 0
]
