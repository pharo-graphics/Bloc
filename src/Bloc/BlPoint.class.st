"
I represent an abstract point. My subclasses are specialized in a certain number of coordinates.
"
Class {
	#name : #BlPoint,
	#superclass : #Object,
	#category : #'Bloc-Basic-Math'
}

{ #category : #comparing }
BlPoint >> < aPoint [
	"Answer whether the receiver is above and to the left of aPoint."
	
	^ self subclassResponsibility
]

{ #category : #converting }
BlPoint >> asPoint2D [
	"Return a projected version of this point on 2D plane (a `BlPoint2D`)"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlPoint >> isPoint [

	^ true
]

{ #category : #comparing }
BlPoint >> max: aBlPoint [

	^ self subclassResponsibility
]

{ #category : #comparing }
BlPoint >> min: aBlPoint [

	^ self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlPoint >> transformedOn: aBlMatrix [
	"Answer a `BlPoint2D`"
	
	^ self subclassResponsibility
]
