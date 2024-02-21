Class {
	#name : #BlPoint,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Math'
}

{ #category : #comparing }
BlPoint >> < aPoint [
	"Answer whether the receiver is above and to the left of aPoint."
	
	^ self subclassResponsibility
]

{ #category : #converting }
BlPoint >> asPoint2D [
	"Return a projected version of this point on 2D plane"
	<return: #BlPoint2D>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlPoint >> isPoint [
	^ true
]

{ #category : #comparing }
BlPoint >> max: aBlPoint [
	<return: #BlPoint>

	^ self subclassResponsibility
]

{ #category : #comparing }
BlPoint >> min: aBlPoint [
	<return: #BlPoint>

	^ self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlPoint >> transformedOn: aBlMatrix [
	<return: #BlPoint>
	
	^ self subclassResponsibility
]
