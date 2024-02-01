"
I allow users to specify a maximum scale value of the content inside of scalable element.

Deafult max scale is set to 1.0

"
Class {
	#name : #BlScalableMaxDecorator,
	#superclass : #BlScalableStrategyDecorator,
	#instVars : [
		'maxScale'
	],
	#category : #'Bloc-Scalable-Strategies'
}

{ #category : #initialization }
BlScalableMaxDecorator >> initialize [
	super initialize.
	
	maxScale := 1.0
]

{ #category : #accessing }
BlScalableMaxDecorator >> maxScale [
	"Return a maximum scale factor of the content element inside of scalable element"
	<return: #Number>

	^ maxScale
]

{ #category : #accessing }
BlScalableMaxDecorator >> maxScale: aNumber [
	self
		assert: [ aNumber > 0 ]
		description: [ 'Scale factor must be greater than 0' ].

	maxScale := aNumber
]

{ #category : #scale }
BlScalableMaxDecorator >> scale: aContentElement within: aScalableElement [
	"Modify a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	
	^ (self strategy scale: aContentElement within: aScalableElement) min: self maxScale
]
