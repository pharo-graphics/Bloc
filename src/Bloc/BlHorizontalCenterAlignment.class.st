Class {
	#name : #BlHorizontalCenterAlignment,
	#superclass : #BlHorizontalAlignment,
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlHorizontalCenterAlignment class >> initialize [
	super initialize.
]

{ #category : #factory }
BlHorizontalCenterAlignment class >> leftToRight [
	^ self center
]

{ #category : #factory }
BlHorizontalCenterAlignment class >> rightToLeft [
	^ self center
]

{ #category : #factory }
BlHorizontalCenterAlignment >> inverted [
	^ BlElementAlignment vertical center
]

{ #category : #factory }
BlHorizontalCenterAlignment >> swap [
	^ self
]

{ #category : #translation }
BlHorizontalCenterAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>
	
	^ ((aContainerBounds width - aBounds width) / 2.0 + aContainerBounds left - aBounds left) @ 0
]
