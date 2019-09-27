"
I make sure that content element fits vertically within scalable element.

It makes sense to use me if scalable element has fixed or matching parent vertical size but fits content horizontally.
"
Class {
	#name : #BlScalableFitHeightStrategy,
	#superclass : #BlScalableStrategy,
	#category : #'Bloc-Utilities - Scalable'
}

{ #category : #comparing }
BlScalableFitHeightStrategy >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
BlScalableFitHeightStrategy >> hash [
	^ self class hash
]

{ #category : #scale }
BlScalableFitHeightStrategy >> scale: aContentElement within: aScalableElement [
	"Compute and return a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	| aMeasuredExtent |
	
	aMeasuredExtent := aContentElement measuredExtent.
	(aMeasuredExtent x * aMeasuredExtent y) isZero
		ifTrue: [ ^ 1.0 ].
	
	^ (aScalableElement measuredHeight / aMeasuredExtent y)
]
