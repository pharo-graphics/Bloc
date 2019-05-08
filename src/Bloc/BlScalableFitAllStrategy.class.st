"
I make sure that content element fits within scalable element in both width and height by taking the smallest side into account.

It makes sense to use me if scalable element has fixed or match parent size, both horizontally and vertically
"
Class {
	#name : #BlScalableFitAllStrategy,
	#superclass : #BlScalableStrategy,
	#category : #'Bloc-Utilities - Scalable'
}

{ #category : #comparing }
BlScalableFitAllStrategy >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
BlScalableFitAllStrategy >> hash [
	^ self class hash
]

{ #category : #scale }
BlScalableFitAllStrategy >> scale: aContentElement within: aScalableElement [
	"Compute and return a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	| aMeasuredExtent |
	
	aMeasuredExtent := aContentElement measuredExtent.
	(aMeasuredExtent x * aMeasuredExtent y) isZero
		ifTrue: [ ^ 1.0 ].

	^ (aScalableElement measuredExtent / aMeasuredExtent) min asFloat
]
