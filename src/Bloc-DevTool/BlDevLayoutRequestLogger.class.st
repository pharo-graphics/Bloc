Class {
	#name : #BlDevLayoutRequestLogger,
	#superclass : #BlElement,
	#category : #'Bloc-DevTool-Core'
}

{ #category : #initialization }
BlDevLayoutRequestLogger >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #initialization }
BlDevLayoutRequestLogger >> requestLayout: anElement from: aSourceElement [
	super requestLayout: anElement from: aSourceElement.
	
	aSourceElement ~~ aSourceElement
		ifTrue: [ ContextStackSignal emit ]
]
