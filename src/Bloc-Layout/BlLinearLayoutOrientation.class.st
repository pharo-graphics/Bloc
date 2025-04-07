Class {
	#name : #BlLinearLayoutOrientation,
	#superclass : #Object,
	#instVars : [
		'layout'
	],
	#category : #'Bloc-Layout-Linear-Utilities'
}

{ #category : #factory }
BlLinearLayoutOrientation class >> horizontal [

	^ BlLinearLayoutHorizontalOrientation new
]

{ #category : #factory }
BlLinearLayoutOrientation class >> vertical [

	^ BlLinearLayoutVerticalOrientation new
]

{ #category : #comparing }
BlLinearLayoutOrientation >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #orientation }
BlLinearLayoutOrientation >> breadthMode [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> breadthProperties: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> breadthSpec: anExtentSpec [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> extentBreadth: breadth lengthSpec: length [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> extentSpecBreadth: breadthSpec lengthSpec: lengthSpec [
	^ self subclassResponsibility
]

{ #category : #comparing }
BlLinearLayoutOrientation >> hash [
	^ self class hash
]

{ #category : #accessing }
BlLinearLayoutOrientation >> inverted [ 

	^ self subclassResponsibility 
]

{ #category : #testing }
BlLinearLayoutOrientation >> isHorizontal [
	^ false
]

{ #category : #testing }
BlLinearLayoutOrientation >> isVertical [
	^ false
]

{ #category : #accessing }
BlLinearLayoutOrientation >> layout [
	^ layout
]

{ #category : #accessing }
BlLinearLayoutOrientation >> layout: aLinearLayout [
	layout := aLinearLayout
]

{ #category : #layout }
BlLinearLayoutOrientation >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> lengthLinearProperties: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> lengthMode [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> lengthProperties: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> lengthSpec: anExtentSpec [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> marginBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> marginLength: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> measureChildWithMargin: child parentSpec: anExtentMeasurementSpec breadthUsed: breadthUsed lengthUsed: lengthUsed [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> measuredBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> measuredLength: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> minimalBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> minimalLength: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> paddingBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
BlLinearLayoutOrientation >> paddingLength: anElement [
	^ self subclassResponsibility
]
