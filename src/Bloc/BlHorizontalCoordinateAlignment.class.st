Class {
	#name : #BlHorizontalCoordinateAlignment,
	#superclass : #BlHorizontalAlignment,
	#instVars : [
		'coordinate',
		'relativeAlignment'
	],
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlHorizontalCoordinateAlignment class >> initialize [

	self initializeSingletons
]

{ #category : #accessing }
BlHorizontalCoordinateAlignment >> coordinate [
	^ coordinate
]

{ #category : #accessing }
BlHorizontalCoordinateAlignment >> coordinate: anObject [
	coordinate := anObject
]

{ #category : #factory }
BlHorizontalCoordinateAlignment >> directed: aBlLayoutDirection [
	^ aBlLayoutDirection of: self
]

{ #category : #initialization }
BlHorizontalCoordinateAlignment >> initialize [

	super initialize.

	coordinate := 0.0.
	relativeAlignment := BlElementAlignment vertical center
]

{ #category : #factory }
BlHorizontalCoordinateAlignment >> leftToRight [
	^ self class new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment leftToRight
]

{ #category : #accessing }
BlHorizontalCoordinateAlignment >> relativeAlignment [
	^ relativeAlignment
]

{ #category : #accessing }
BlHorizontalCoordinateAlignment >> relativeAlignment: anObject [
	relativeAlignment := anObject
]

{ #category : #factory }
BlHorizontalCoordinateAlignment >> rightToLeft [
	^ self class new
		coordinate: coordinate;
		relativeAlignment: relativeAlignment rightToLeft 
]
