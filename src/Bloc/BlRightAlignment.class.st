"
I represent right alignment.
See BlLayoutAlignment for more info.

"
Class {
	#name : #BlRightAlignment,
	#superclass : #BlHorizontalAlignment,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlRightAlignment class >> initialize [
	super initialize.
]

{ #category : #factory }
BlRightAlignment class >> leftToRight [
	^ self right
]

{ #category : #factory }
BlRightAlignment class >> rightToLeft [
	^ self left
]

{ #category : #factory }
BlRightAlignment >> inverted [
	^ BlElementAlignment vertical end
]

{ #category : #factory }
BlRightAlignment >> swap [
	^ BlElementAlignment left
]

{ #category : #translation }
BlRightAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>
	
	^ (aContainerBounds width - aBounds width + aContainerBounds left - aBounds left) @ 0
]
