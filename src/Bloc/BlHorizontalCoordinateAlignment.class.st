Class {
	#name : #BlHorizontalCoordinateAlignment,
	#superclass : #BlHorizontalAlignment,
	#instVars : [
		'coordinate',
		'relativeAlignment'
	],
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : 'accessing' }
BlHorizontalCoordinateAlignment >> coordinate [
	^ coordinate
]

{ #category : 'accessing' }
BlHorizontalCoordinateAlignment >> coordinate: anObject [
	coordinate := anObject
]

{ #category : 'factory' }
BlHorizontalCoordinateAlignment >> directed: aBlLayoutDirection [
	^ aBlLayoutDirection of: self
]

{ #category : 'initialization' }
BlHorizontalCoordinateAlignment >> initialize [
	super initialize.
	
	coordinate := 0.0.
	relativeAlignment := BlElementAlignment horizontal center
]

{ #category : 'accessing' }
BlHorizontalCoordinateAlignment >> relativeAlignment [
	^ relativeAlignment
]

{ #category : 'accessing' }
BlHorizontalCoordinateAlignment >> relativeAlignment: anObject [
	relativeAlignment := anObject
]
